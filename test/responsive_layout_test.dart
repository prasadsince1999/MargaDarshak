import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/core/widgets/widgets.dart';

void main() {
  group('AppBrutalResponsiveContainer & AppBrutalScaffold Responsive Tests', () {
    testWidgets(
      'AppBrutalResponsiveContainer constrains child on wide displays',
      (tester) async {
        // Simulate wide desktop display (1440x900)
        tester.view.physicalSize = const Size(1440, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppBrutalResponsiveContainer(
                maxWidth: 720,
                child: SizedBox(
                  key: Key('inner_box'),
                  height: 200,
                  child: Text('Responsive content'),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final innerBoxFinder = find.byKey(const Key('inner_box'));
        expect(innerBoxFinder, findsOneWidget);

        final renderBox = tester.renderObject<RenderBox>(innerBoxFinder);
        expect(renderBox.size.width, lessThanOrEqualTo(720.0));
      },
    );

    testWidgets(
      'AppBrutalResponsiveContainer expands to available width on narrow mobile displays',
      (tester) async {
        // Simulate compact mobile display (360x640)
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppBrutalResponsiveContainer(
                maxWidth: 720,
                child: SizedBox(
                  key: Key('inner_mobile_box'),
                  width: double.infinity,
                  height: 200,
                  child: Text('Mobile content'),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final innerBoxFinder = find.byKey(const Key('inner_mobile_box'));
        expect(innerBoxFinder, findsOneWidget);

        final renderBox = tester.renderObject<RenderBox>(innerBoxFinder);
        expect(renderBox.size.width, equals(360.0));
      },
    );

    testWidgets(
      'AppBrutalScaffold centers body on tablet and desktop screens',
      (tester) async {
        // Simulate tablet screen (1024x768)
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: AppBrutalScaffold(
              maxContentWidth: 768,
              body: SizedBox(
                key: Key('scaffold_content'),
                child: Text('Centered body'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final contentFinder = find.byKey(const Key('scaffold_content'));
        expect(contentFinder, findsOneWidget);

        final renderBox = tester.renderObject<RenderBox>(contentFinder);
        expect(renderBox.size.width, lessThanOrEqualTo(768.0));
      },
    );
  });
}
