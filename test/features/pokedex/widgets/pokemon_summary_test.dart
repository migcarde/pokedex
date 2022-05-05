import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';

import '../pokedex_view_model_mock.dart';

void main() {
  testWidgets(
    'Pokemon summary with one tag',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonSummary(
            pokemon: pokedexViewModelComplete,
          ),
        ),
      );

      // We search capitalize texts because pokemon summary widget capitalize it.
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('Description');
      final pokemonTypeObjectFinder = find.byType(PokemonType);
      final pokemonTypeFinder = find.text('types');

      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);
      expect(pokemonTypeFinder, findsOneWidget);
      expect(pokemonTypeObjectFinder, findsOneWidget);
    }),
  );

  testWidgets(
    'Pokemon summary with two tags',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonSummary(
            pokemon: pokedexViewModelCompleteTwoTags,
          ),
        ),
      );

      // We search capitalize texts because pokemon summary widget capitalize it.
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('Description');
      final pokemonTypeObjectFinder = find.byType(PokemonType);
      final pokemonTypeFinder = find.text('types');
      final pokemonTypeSecondFinder = find.text('example');

      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);
      expect(pokemonTypeFinder, findsOneWidget);
      expect(pokemonTypeSecondFinder, findsOneWidget);
      expect(pokemonTypeObjectFinder, findsNWidgets(2));
    }),
  );

  testWidgets(
    'Pokemon summary without tags',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonSummary(
            pokemon: pokedexViewModelTypesEmpty,
          ),
        ),
      );

      // We search capitalize texts because pokemon summary widget capitalize it.
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('Description');
      final pokemonTypeObjectFinder = find.byType(PokemonType);

      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);
      expect(pokemonTypeObjectFinder, findsNothing);
    }),
  );

  testWidgets(
    'Pokemon summary with tags - No capitalization of Name and Summary parameters',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokemonSummary(
            pokemon: pokedexViewModelComplete,
          ),
        ),
      );

      // We search capitalize texts because pokemon summary widget capitalize it.
      final pokemonNameFinder = find.text('name');
      final pokemonDescriptionFinder = find.text('description');
      final pokemonTypeObjectFinder = find.byType(PokemonType);
      final pokemonTypeFinder = find.text('types');

      expect(pokemonNameFinder, findsNothing);
      expect(pokemonDescriptionFinder, findsNothing);
      expect(pokemonTypeFinder, findsOneWidget);
      expect(pokemonTypeObjectFinder, findsOneWidget);
    }),
  );
}
