import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/storage/local_persistence.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Android 15+ enforces edge-to-edge; declaring it makes the behaviour the
  // same on older versions instead of only on new ones.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // The app surface is warm paper, so system bar icons must be dark or the
  // clock, battery and signal are invisible. Without this the only screen
  // that sets an overlay style is the splash, and the style reverts the
  // moment it unmounts.
  SystemChrome.setSystemUIOverlayStyle(_paperOverlayStyle);

  // Async-init SharedPreferences before the widget tree.
  final persistence = await LocalPersistence.create();

  runApp(
    ProviderScope(
      overrides: [localPersistenceProvider.overrideWithValue(persistence)],
      child: const MargadarshakApp(),
    ),
  );
}

/// Root widget for the Margadarshak application.
///
/// Wraps everything in [ProviderScope] (Riverpod) and applies the
/// design system theme via [AppTheme].
///
/// Uses [ConsumerWidget] to access the router factory which needs
/// [WidgetRef] for the onboarding gate redirect.
class MargadarshakApp extends ConsumerWidget {
  const MargadarshakApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _paperOverlayStyle,
      child: _buildApp(ref),
    );
  }

  Widget _buildApp(WidgetRef ref) {
    return MaterialApp.router(
      title: 'Margadarshak',
      debugShowCheckedModeBanner: false,
      // Theme from design tokens
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      // Router (with onboarding gate)
      routerConfig: createAppRouter(ref),
      // Localization (ready for expansion)
      supportedLocales: const [Locale('en')],
    );
  }
}

/// System bar styling for the app's warm paper surface: transparent bars with
/// dark icons. The app is locked to light mode (see docs/04-engineering.md
/// § Theme Lock), so this does not need a dark variant yet.
const SystemUiOverlayStyle _paperOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarContrastEnforced: false,
);
