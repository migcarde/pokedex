import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';

void main() {
  testWidgets('Show pokemon type widget', ((WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PokemonType(
          type: PokemonTypes.bug,
        ),
      ),
    );

    final typeTextFinder = find.text('Bug');

    expect(typeTextFinder, findsOneWidget);
  }));
}
