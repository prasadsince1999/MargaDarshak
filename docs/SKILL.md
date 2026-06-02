---
name: flutter-rules
description: >
  Dart 3 and Flutter coding rules for Project Jarvis covering naming, layering,
  widget rebuild discipline, 120fps rendering budgets, Impeller behavior,
  isolate offloading, Dart 3 sealed classes / pattern matching, platform
  channel patterns, stream idioms, enterprise security (Hive AES-256, SSL
  pinning, obfuscation, jailbreak detection), and the unit/widget/integration
  testing pyramid. Use whenever writing, editing, reviewing, or refactoring
  any `.dart` file; working on Platform Channels, native bridges, audio
  buffers; touching state management, async flows, or layer boundaries;
  handling sensitive user data, auth tokens, biometric markers, or API keys;
  wiring up network clients; diagnosing jank, dropped frames, or memory
  bloat — even if the request does not explicitly name "Flutter rules."
---

# Flutter / Dart Rules — Project Jarvis

A synthesis of project-specific conventions and professional-grade Flutter /
Dart 3 practices. Enforce on every `.dart` file.

---

## 1. Naming & File Hygiene

- Files, packages, directories: `lowercase_with_underscores`
- Types (classes, enums, typedefs): `UpperCamelCase`
- Variables, methods, params: `lowerCamelCase`
- Private identifiers: leading underscore (`_internalState`)
- Constants: `lowerCamelCase` for `const` locals/fields, `SCREAMING_SNAKE_CASE`
  only for top-level ABI-style constants crossing platform channels

### File Headers

Every `.dart` file must start with a 3-line header:
```dart
// FILE: filename.dart
// LAYER: SERVICE | MODEL | FEATURE | PROVIDER | APP | TEST
// PURPOSE: One-sentence description of what this file does.
```

### Imports (Ordered)

1. `dart:` core libraries
2. `package:` dependencies
3. Relative project imports

Run `dart format` on every changed file. Use `flutter_lints`. Line length 100.

---

## 2. Performance: Frame Budgets & Jank Diagnosis

Flutter renders at the display's refresh rate. Every frame must finish build +
layout + paint + raster inside the budget or the frame is dropped.

| Refresh | Budget | Notes |
|:--|:--|:--|
| 60 fps | ~16.6 ms | Baseline; legacy hardware |
| 90 fps | ~11.1 ms | Mid-range modern devices |
| 120 fps | ~8.3 ms | Flagship; demands aggressive optimization |

### Diagnosing Jank

- Profile with **`flutter run --profile`**, never `--debug` (debug mode keeps
  assertions that skew timings).
- Open **DevTools → Performance → Flutter frames chart** and read per-thread
  time for UI (Dart) and Raster (GPU).
- If UI thread is hot → reduce rebuild radius, move work to isolates.
- If Raster thread is hot → reduce overdraw, add `RepaintBoundary`, avoid
  `Opacity`/`Clip`/`saveLayer()` during animation.

### Threading Model (Flutter 3.29+)

Dart runs on the platform's main thread on Android/iOS — no separate UI
thread. Platform calls are direct and synchronous-capable, but **blocking
Dart still blocks the frame**. Offload heavy work.

---

## 3. Rebuild Radius Control

The #1 cause of Flutter jank is unnecessary `build()` calls.

- **Localize `setState()`** to the smallest widget that owns the mutating
  state. Do not call it on a screen-level widget for a single spinner.
- **`const` constructors are mandatory** on any widget that takes no mutating
  parameters. `const` lets the element tree short-circuit rebuilds.
- With Provider: use `context.select<P, T>((p) => p.field)` or `Selector` /
  `Consumer` — never `context.watch<P>()` on whole providers in deep trees.
- With Bloc: `BlocBuilder` must carry `buildWhen` whenever the state class
  bundles multiple fields.
- Never rebuild a list's parent on per-item changes — push the selector
  into the item widget.

---

## 4. Rendering Optimization

### `RepaintBoundary`

Wrap computationally expensive or frequently-repainting subtrees
(animations, video, real-time progress, charts, particle effects). The
boundary isolates a display list so surrounding static layers are cached and
composited instead of repainted.

### Expensive Operations — Use With Care

- **`Opacity`**: forces an off-screen buffer. In animations, use
  `AnimatedOpacity`, `FadeTransition`, or pre-bake alpha into the color
  (`Color.withValues(alpha: …)`).
- **`Clip*` (non-rect)**: dynamic clipping is GPU-heavy. Pre-clip/frame assets
  where possible. `Clip.hardEdge` is cheaper than `Clip.antiAlias`.
- **`saveLayer()`**: breaks the GPU pipeline by allocating intermediate
  buffers. Avoid except where unavoidable.
- **Blurs, shadows with large `blurRadius`**: expensive; cache via
  `RepaintBoundary` when static.

### Impeller

Flutter's default engine (Metal on iOS, Vulkan on Android). Shaders are
AOT-compiled, eliminating runtime shader-compilation jank. Rely on Impeller
defaults — do not re-introduce custom shader warm-up routines.

---

## 5. Concurrency & Isolates

The main isolate runs UI, gestures, and frame scheduling. Blocking it freezes
the app.

### Offload to Isolates

Use **`compute(fn, input)`** for:
- Large JSON parsing (`jsonDecode` of >50 KB payloads)
- Image filtering / resize / encode
- Cryptographic hashing, AES-GCM bulk encrypt/decrypt
- Isar migrations or bulk writes
- LLM token post-processing (regex sweeps, sentencization)

Isolates have **separate memory heaps** — communicate only via messages
(primitives, `TransferableTypedData`, or serialized structures). No shared
mutable state. No direct widget access.

### Long-Running Isolates

For repeated work (streaming inference workers), spawn a long-lived isolate
with `Isolate.spawn` + a `SendPort` and reuse it. Cold-starting an isolate
per call costs hundreds of ms.

---

## 6. Asset & List Management

### Lists

- **`ListView(children: […])` / `GridView(children: […])` are banned** for any
  list that can grow. Forces full layout of every child on mount.
- Use **`ListView.builder`**, **`GridView.builder`**, **`SliverList`**.
- Tune `cacheExtent` — too low → scroll stutter; too high → memory bloat.
  Default is usually fine; only change with a measured reason.
- Give list items stable `Key`s only when reordering / dedup matters.

### Images

- Prefer **WebP** over JPEG/PNG (~30% smaller).
- Supply **`cacheWidth` / `cacheHeight`** (or `memCacheWidth` for
  `CachedNetworkImage`) so the decoder downscales into RAM. Loading a 4K asset
  into a 400 px widget wastes ~40× the memory needed.
- Use `cached_network_image` for network images to avoid redundant fetches.

---

## 7. Widget Rules

Widgets render and dispatch intent — nothing else.

- Business logic → services, use-cases, repositories
- Prefer `const` constructors (reduces rebuilds)
- Split large `build()` methods into smaller widgets, not helper methods —
  widgets get the `const` optimization; methods do not.
- No side effects in `build()`: no network, no persistence, no navigation,
  no `notifyListeners()`. Side effects belong in `initState`, event handlers,
  or explicit lifecycle hooks.

---

## 8. State Management (ChangeNotifier + Provider)

- `ChatProvider` = UI state bridge between services and screens
- Providers hold UI state only — domain state lives in services
- One source of truth per domain — never duplicate state
- **Throttle `notifyListeners()` during rapid token streaming** — batch tokens
  and notify every ~50 ms, not per-token (prevents excessive widget rebuilds)
- Use `context.select<Provider, T>((p) => p.field)` to limit rebuilds to
  specific properties instead of rebuilding on every change

---

## 9. Async Discipline

- **Never use `Future.delayed` to fix race conditions** — redesign the boundary
- Async methods must complete their contract before returning
- Handle cancellation, disposal order, and re-entrancy carefully
- Getters must not trigger network calls, persistence, or navigation
- Always check `mounted` before `setState` / `context` use in async callbacks
- Subscriptions (`StreamSubscription`, `Timer`, `AnimationController`) must be
  cancelled/disposed in `dispose()`

---

## 10. Side Effect Naming

- `fetch`, `save`, `update`, `delete`, `execute`, `sync`, `load` → side effects
- `get`, `calculate`, `compute` → pure reads only
- Hidden writes during reads, rendering, or lazy init are banned

---

## 11. Layer Boundaries

| Layer | Scope | Key Directories |
|:--|:--|:--|
| Domain | Models, enums, pure logic | `lib/models/`, `lib/features/*/domain/` |
| App | Services, orchestration, use-cases | `lib/services/`, `lib/ai/`, `lib/features/*/application/` |
| UI | Screens, widgets, providers | `lib/features/*/presentation/`, `lib/widgets/`, `lib/providers/` |
| Infra | DB, plugins, platform, repo impls | `lib/repositories/`, `lib/features/*/infrastructure/`, `plugins/`, `android/` |

**Domain must import zero Flutter packages.** If `package:flutter/…` appears
in `lib/models/**` or a feature's `domain/`, it is a layering bug.

---

## 12. Feature Architecture (Clean Architecture, Feature-First)

New features follow the `features/health/` reference implementation:

```
lib/features/<feature>/
  domain/         # Entities, value objects, repository interfaces (abstract)
  infrastructure/ # Repository implementations, data sources, DTOs
  application/    # Services, use-cases, orchestration, business logic
  presentation/
    screens/      # Full-page widgets
    widgets/      # Reusable UI components
```

Each feature is self-contained. Cross-feature dependency goes through the
**application layer** (a service in one feature consumes another feature's
service or repository interface), never screen-to-screen or
widget-to-widget.

---

## 13. Dart 3 Paradigms

### Sealed Classes + Exhaustive Switch

Model finite state spaces as `sealed class` hierarchies:

```dart
sealed class ModelState {}
final class ModelUnloaded extends ModelState {}
final class ModelLoading extends ModelState {
  final double progress;
  ModelLoading(this.progress);
}
final class ModelReady extends ModelState {
  final String modelId;
  ModelReady(this.modelId);
}
final class ModelError extends ModelState {
  final Object error;
  ModelError(this.error);
}
```

Consume with switch **expressions** so the compiler enforces exhaustiveness:

```dart
final label = switch (state) {
  ModelUnloaded()        => 'Idle',
  ModelLoading(:final progress) => '${(progress * 100).toInt()}%',
  ModelReady(:final modelId)    => 'Ready ($modelId)',
  ModelError(:final error)      => 'Error: $error',
};
```

Adding a new subclass immediately breaks every switch until handled —
eliminates "unhandled state" runtime crashes.

### Records

Use records for small, throwaway heterogeneous bundles — return values,
tuple-like keys, local grouping. Do **not** use records for entities that
belong in the domain layer (those stay as named classes with validation).

```dart
(double, double) computeBounds(List<Offset> pts) { … }
final (lat, lng) = locationRecord;
```

### Pattern Destructuring

Prefer destructuring over positional/indexed access for JSON, maps, records:

```dart
if (json case {'id': int id, 'name': String name, 'age': int age}) {
  return User(id: id, name: name, age: age);
}
```

Fails safely to the `else` branch if any key is missing or the wrong type.

---

## 14. Platform Channel Patterns (Kotlin ↔ Dart)

Used for wake word service, Health Connect, and native audio.

### MethodChannel (Request-Response)
```dart
static const _channel = MethodChannel('channel_name');
Future<String> doSomething(String input) async {
  final result = await _channel.invokeMethod<String>('method', {'key': input});
  return result ?? '';
}
```

### EventChannel (Streaming)
```dart
static const _streamChannel = EventChannel('channel_name/stream');
Stream<Map<String, dynamic>> get eventStream =>
  _streamChannel.receiveBroadcastStream()
    .map((event) => Map<String, dynamic>.from(event as Map));
```

### Data Type Mappings

| Dart | Kotlin | Use |
|:--|:--|:--|
| `Uint8List` | `ByteArray` | Audio WAV bytes, binary data |
| `Float32List` | `FloatArray` | Audio samples, tensor data |
| `String` | `String` | Text tokens, prompts |
| `Map<String, dynamic>` | `HashMap<String, Any>` | Event payloads |

**Pass file paths (not raw bytes) for large data** to avoid OOM on the channel.

---

## 15. Stream Patterns

### Broadcast vs Single-Subscription

- **`StreamController.broadcast()`** — multiple consumers (UI, logging, analytics).
  Events without listeners are DISCARDED (not buffered).
- **`StreamController()`** — single consumer, guaranteed delivery.
  But beware memory buildup from buffering if consumer is slow.

### Completer Pattern (Callback → Future)

```dart
final completer = Completer<String>();
_channel.invokeMethod('generate', {'text': text}).then((result) {
  if (!completer.isCompleted) {  // ALWAYS check — prevents double-complete crash
    completer.complete(result);
  }
});
return completer.future;
```

---

## 16. Security: Sensitive Data & Transit

Standard `SharedPreferences` is **plain-text XML/JSON** on disk and must
never hold PII, auth tokens, biometric markers, health data, or API keys.

### Local Storage — Hive AES-256 via `flutter_secure_storage`

1. **Generate a 256-bit key** with `Hive.generateSecureKey()` (uses
   cryptographically secure RNG under the hood). Never hardcode keys.
2. **Persist the key in the hardware-backed store** via
   `flutter_secure_storage` — this routes to the Android Keystore and iOS
   Keychain (Secure Enclave), not the filesystem.
3. **Open encrypted boxes** with the retrieved key:
   ```dart
   final encryptionKey = await _loadOrCreateKey();
   final box = await Hive.openBox<Entry>(
     'secure_entries',
     encryptionCipher: HiveAesCipher(encryptionKey),
   );
   ```
4. **Encrypt/decrypt large payloads inside `compute()`** — AES is CPU-bound
   and will drop frames if run on the main isolate.

For health data specifically, stay within the Health Connect APIs when
possible; never cache raw biometric records in plain `SharedPreferences`.

### Network Transit

- Enforce **TLS 1.2+** at the HTTP client layer. Disable 1.0/1.1 explicitly.
- **Certificate pinning** for any endpoint carrying auth or user data —
  embed the SPKI hash of the server cert and reject mismatches during
  handshake. Rotate pins alongside server cert rotation; ship at least one
  backup pin.
- Never log full request bodies or `Authorization` headers in release builds.

### Runtime Hardening

- **Release builds must use** `flutter build --obfuscate --split-debug-info=…`.
  Save the debug-info directory per release so crashes can be de-obfuscated.
- **Android**: keep `proguard-rules.pro` strict; shrink + obfuscate the
  Kotlin/Java layer too.
- **Jailbreak / root detection**: integrate `flutter_jailbreak_detection` (or
  equivalent) on release builds, and fail-closed for features that handle
  financial or health data.
- **Background snapshot cloaking**: for screens showing sensitive data, apply
  `secure_application` (or a manual blur overlay on `AppLifecycleState.paused`)
  so the OS task-switcher snapshot doesn't leak content.
- **Principle of least privilege**: every permission declared in
  `AndroidManifest.xml` / `Info.plist` must map to a feature actually in use.
  Audit on every release cut.

---

## 17. Testing Pyramid

Target roughly:

| Tier | Share | Scope |
|:--|:--|:--|
| Unit | ~70% | Domain entities, use-cases, services, pure Dart logic. Zero Flutter imports in the code under test. |
| Widget | ~20% | Presentation widgets rendering against fake services/state. Headless (`flutter test`), no emulator. |
| Integration | ~10% | End-to-end flows on a real device/emulator: auth, payments, on-device AI round-trip, Health Connect sync. |

Rules:
- A bug fix **must** land with a failing-then-passing unit or widget test.
- Do not mock what you own at the unit layer when a real instance is cheap —
  mock only I/O boundaries (network, platform channels, Isar, filesystem).
- Keep tests deterministic: no wall-clock `DateTime.now()`, no real random —
  inject a clock / `Random.seeded`.

---

## 18. Key Dependencies (Exact Versions)

| Package | Version | Purpose |
|:--|:--|:--|
| `isar_community` | 4.0.0-dev.14 | Structured database |
| `sherpa_onnx` | ^1.10.43 | Piper TTS + KWS |
| `just_audio` | ^0.9.43 | Audio playback |
| `record` | ^5.2.1 | Audio recording |
| `health` | ^12.2.0 | Health Connect API |
| `speech_to_text` | ^7.0.0 | Platform STT |
| `flutter_tts` | ^4.2.0 | System TTS |
| `firebase_ai` | latest | Firebase AI Logic (Gemini Live) |
| `google_generative_ai` | latest | Google AI SDK (Gemini Chat) |

### Android Native Dependencies

| Dependency | Version | Purpose |
|:--|:--|:--|
| `com.google.ai.edge.litert:litert` | 1.4.1 | TFLite wake word |

Build config: `compileSdk=35`, `minSdk=26`, `targetSdk=35`, `NDK=27.0.12077973`.

---

## 19. Code Generation

After any Isar schema change:
```bash
dart run build_runner build --delete-conflicting-outputs
```
Generated files: `lib/models/*.g.dart` (14 files) — never edit manually.
Commit generated files alongside the schema change in the same commit.
