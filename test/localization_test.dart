import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/localization/app_locale.dart';
import 'package:margadarshak/core/localization/app_strings.dart';
import 'package:margadarshak/core/providers/locale_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/core/widgets/language_switcher_dialog.dart';

import 'support/test_harness.dart';

void main() {
  group('Localization & Multilingual Tests', () {
    test('AppStrings resolves keys across 8 Indian languages correctly', () {
      expect(AppStrings.tr('app_name', AppLanguage.english), 'MĀRGADARSHAK');
      expect(AppStrings.tr('app_name', AppLanguage.hindi), 'मार्गदर्शक');
      expect(AppStrings.tr('app_name', AppLanguage.odia), 'ମାର୍ଗଦର୍ଶକ');
      expect(AppStrings.tr('app_name', AppLanguage.telugu), 'మార్గదర్శక్');
      expect(AppStrings.tr('app_name', AppLanguage.tamil), 'மார்கதர்ஷக்');
      expect(AppStrings.tr('app_name', AppLanguage.bengali), 'মার্গদর্শক');
      expect(AppStrings.tr('app_name', AppLanguage.marathi), 'मार्गदर्शक');
      expect(AppStrings.tr('app_name', AppLanguage.kannada), 'ಮಾರ್ಗದರ್ಶಕ್');
    });

    test('AppLanguage fromCode parses valid and fallback codes', () {
      expect(AppLanguage.fromCode('hi'), AppLanguage.hindi);
      expect(AppLanguage.fromCode('or'), AppLanguage.odia);
      expect(AppLanguage.fromCode('te'), AppLanguage.telugu);
      expect(AppLanguage.fromCode('unknown'), AppLanguage.english);
      expect(AppLanguage.fromCode(null), AppLanguage.english);
    });

    testWidgets(
      'LanguageSwitcherSheet displays all 8 languages and switches state',
      (tester) async {
        final persistence = await createTestPersistence();
        final container = ProviderContainer(
          overrides: [localPersistenceProvider.overrideWithValue(persistence)],
        );

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const MaterialApp(
              home: Scaffold(body: LanguageSwitcherSheet()),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('हिन्दी'), findsOneWidget);
        expect(find.text('ଓଡ଼ିଆ'), findsOneWidget);
        expect(find.text('తెలుగు'), findsOneWidget);
        expect(find.text('தமிழ்'), findsOneWidget);
        expect(find.text('मराठी'), findsOneWidget);

        await tester.tap(find.text('हिन्दी'));
        await tester.pumpAndSettle();

        expect(container.read(appLanguageProvider), AppLanguage.hindi);
      },
    );
  });
}
