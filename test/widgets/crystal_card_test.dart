import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/widgets/crystal_card.dart';

void main() {
  testWidgets('Crystal card has text widget', ((WidgetTester tester) async {
    await tester.pumpWidget(
      const CrystalCard(
        child: Text(
          'hello',
          textDirection: TextDirection.ltr,
        ),
      ),
    );

    final textFinder = find.text('hello');

    expect(textFinder, findsOneWidget);
  }));
}
