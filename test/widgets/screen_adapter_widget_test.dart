import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/widgets/screen_adapter_widget.dart';

void main() {
  testWidgets(
    'Screen adapter widget has mobile screen',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ScreenAdapterWidget(
            mobileScreen: SizedBox(),
          ),
        ),
      );

      final mobileScreenFinder = find.byType(SizedBox);

      expect(mobileScreenFinder, findsOneWidget);
    }),
  );

  testWidgets(
    'Screen adapter widget use mobile screen with 600x600 screen size',
    ((WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(600, 600);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: ScreenAdapterWidget(
            mobileScreen: SizedBox(),
            tabletScreen: CircularProgressIndicator(),
          ),
        ),
      );

      final mobileScreenFinder = find.byType(SizedBox);

      expect(mobileScreenFinder, findsOneWidget);
    }),
  );

  testWidgets(
    'Screen adapter widget use tabletScreen screen with 800x800 screen size',
    ((WidgetTester tester) async {
      // TODO: Check how to adjust screen size
      tester.binding.window.physicalSizeTestValue = const Size(2800, 2800);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: ScreenAdapterWidget(
            mobileScreen: SizedBox(),
            tabletScreen: CircularProgressIndicator(),
          ),
        ),
      );

      final tabletScreenFinder = find.byType(CircularProgressIndicator);

      expect(tabletScreenFinder, findsOneWidget);
    }),
  );
}
