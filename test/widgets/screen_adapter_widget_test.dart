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
    'Screen adapter widget use mobile screen with 200x200 screen size',
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
    'Screen adapter widget use mobile screen with 200x200 screen size with all parameters',
    ((WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(600, 600);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: ScreenAdapterWidget(
            mobileScreen: SizedBox(),
            tabletScreen: CircularProgressIndicator(),
            desktopScreen: Text('data'),
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
      tester.binding.window.physicalSizeTestValue = const Size(2400, 2400);
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

  testWidgets(
    'Screen adapter widget use tabletScreen screen with 800x800 screen size on widget with all parameters',
    ((WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(2400, 2400);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: ScreenAdapterWidget(
            mobileScreen: SizedBox(),
            tabletScreen: CircularProgressIndicator(),
            desktopScreen: Text('data'),
          ),
        ),
      );

      final tabletScreenFinder = find.byType(CircularProgressIndicator);

      expect(tabletScreenFinder, findsOneWidget);
    }),
  );

  testWidgets(
    'Screen adapter widget use tablet screen with 1333x1333 screen size',
    ((WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(4000, 4000);
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

  testWidgets(
    'Screen adapter widget use desktop screen with 1333x1333 screen size',
    ((WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(4000, 4000);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: ScreenAdapterWidget(
            mobileScreen: SizedBox(),
            tabletScreen: CircularProgressIndicator(),
            desktopScreen: Text('data'),
          ),
        ),
      );

      final desktopScreenFinder = find.byType(Text);

      expect(desktopScreenFinder, findsOneWidget);
    }),
  );
}
