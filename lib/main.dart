import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/storage/local_persistence.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
