import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/data/seed/document_seeds.dart';
import 'package:margadarshak/features/documents/presentation/documents_radar_screen.dart';

import 'support/test_harness.dart';

void main() {
  group('Document Seeds Dataset Tests', () {
    test('seedDocumentTypes contains canonical Indian documents', () {
      expect(seedDocumentTypes.length, greaterThanOrEqualTo(10));
      expect(seedDocumentTypes.any((d) => d.id == 'doc_aadhaar'), isTrue);
      expect(seedDocumentTypes.any((d) => d.id == 'doc_domicile'), isTrue);
      expect(seedDocumentTypes.any((d) => d.id == 'doc_income_cert'), isTrue);
      expect(seedDocumentTypes.any((d) => d.id == 'doc_category_cert'), isTrue);
      expect(
        seedDocumentTypes.any((d) => d.id == 'doc_disability_cert'),
        isTrue,
      );
    });
  });

  group('DocumentsRadarScreen Widget Tests', () {
    testWidgets(
      'renders document radar screen with progress, warning, and cards',
      (tester) async {
        await pumpScreen(tester, const DocumentsRadarScreen());

        await tester.pumpAndSettle();

        expect(find.text('DOCUMENTS & DEADLINES'), findsOneWidget);
        expect(find.text('VERIFICATION READINESS'), findsOneWidget);
        expect(
          find.text('CRITICAL ADMISSION RULE (APRIL 1 RULE)'),
          findsOneWidget,
        );
        expect(find.text('ALL DOCUMENTS'), findsOneWidget);
        expect(find.text('IDENTITY & ADDRESS'), findsOneWidget);
        expect(find.text('Aadhaar Card'), findsOneWidget);
        expect(find.text('🟢 READY'), findsWidgets);
      },
    );

    testWidgets('tapping status button updates readiness count', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await pumpScreen(tester, const DocumentsRadarScreen());

      await tester.pumpAndSettle();

      expect(find.text('0 / 13 READY'), findsOneWidget);

      final readyButton = find.text('🟢 READY').first;
      await tester.tap(readyButton);
      await tester.pumpAndSettle();

      expect(find.text('1 / 13 READY'), findsOneWidget);
    });
  });
}
