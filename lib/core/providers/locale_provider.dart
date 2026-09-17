import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/app_locale.dart';
import '../storage/local_persistence.dart';

/// Provides the active [AppLanguage] across the application with persistent state.
final appLanguageProvider = NotifierProvider<AppLanguageNotifier, AppLanguage>(
  AppLanguageNotifier.new,
);

class AppLanguageNotifier extends Notifier<AppLanguage> {
  @override
  AppLanguage build() {
    try {
      final persistence = ref.read(localPersistenceProvider);
      final savedCode = persistence.loadLanguage();
      return AppLanguage.fromCode(savedCode);
    } catch (_) {
      return AppLanguage.english;
    }
  }

  void setLanguage(AppLanguage language) {
    state = language;
    try {
      final persistence = ref.read(localPersistenceProvider);
      persistence.saveLanguage(language.code);
    } catch (_) {}
  }
}
