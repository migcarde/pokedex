import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_desktop_card.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';

import '../pokedex_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);
  testWidgets(
    'Show pokemon desktop card',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokedexDesktopCard(
            pokemon: pokedexViewModelComplete,
          ),
        ),
      );

      final pokedexDesktopCardFinder = find.byType(PokedexDesktopCard);

      // Summary widget finders
      final pokemonSummaryFinder = find.byType(PokemonSummary);
      final pokemonNameFinder = find.text('Name');
      final pokemonDescripitonFinder = find.text('Description');
      final pokemonTypesFinder = find.byType(PokemonType);
      final pokemonTypesNameFinder = find.text('types');

      // Pokemon display widget finders
      final pokemonDisplayFinder = find.byType(PokemonDisplay);
      final pokemonCrystalCardFinder = find.byType(PokemonDisplay);
      final pokemonImageFinder = find.byType(Image);

      expect(pokedexDesktopCardFinder, findsOneWidget);

      // Summary widget expect
      expect(pokemonSummaryFinder, findsOneWidget);
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescripitonFinder, findsOneWidget);
      expect(pokemonTypesFinder, findsOneWidget);
      expect(pokemonTypesNameFinder, findsOneWidget);

      // Pokemon display widget expect
      expect(pokemonDisplayFinder, findsOneWidget);
      expect(pokemonCrystalCardFinder, findsOneWidget);
      expect(pokemonImageFinder, findsOneWidget);
    }),
  );

  testWidgets(
    'Show pokemon desktop card - Empty types',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokedexDesktopCard(
            pokemon: pokedexViewModelTypesAndStatsEmpty,
          ),
        ),
      );

      final pokedexDesktopCardFinder = find.byType(PokedexDesktopCard);

      // Summary widget finders
      final pokemonSummaryFinder = find.byType(PokemonSummary);
      final pokemonNameFinder = find.text('Name');
      final pokemonDescripitonFinder = find.text('Description');
      final pokemonTypesFinder = find.byType(PokemonType);

      // Pokemon display widget finders
      final pokemonDisplayFinder = find.byType(PokemonDisplay);
      final pokemonCrystalCardFinder = find.byType(PokemonDisplay);
      final pokemonImageFinder = find.byType(Image);

      expect(pokedexDesktopCardFinder, findsOneWidget);

      // Pokemon summary widget expect
      expect(pokemonSummaryFinder, findsOneWidget);
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescripitonFinder, findsOneWidget);
      expect(pokemonTypesFinder, findsNothing);

      // Pokemon display widget expect
      expect(pokemonDisplayFinder, findsOneWidget);
      expect(pokemonCrystalCardFinder, findsOneWidget);
      expect(pokemonImageFinder, findsOneWidget);
    }),
  );

  testWidgets(
    'Show pokemon desktop card - Two tags',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PokedexDesktopCard(
            pokemon: pokedexViewModelCompleteTwoTags,
          ),
        ),
      );

      final pokedexDesktopCardFinder = find.byType(PokedexDesktopCard);

      // Summary widget finders
      final pokemonSummaryFinder = find.byType(PokemonSummary);
      final pokemonNameFinder = find.text('Name');
      final pokemonDescripitonFinder = find.text('Description');
      final pokemonTypesFinder = find.byType(PokemonType);
      final pokemonTypesNameTypesFinder = find.text('types');
      final pokemonTypesNameExampleFinder = find.text('example');

      // Pokemon display widget finders
      final pokemonDisplayFinder = find.byType(PokemonDisplay);
      final pokemonCrystalCardFinder = find.byType(PokemonDisplay);
      final pokemonImageFinder = find.byType(Image);

      expect(pokedexDesktopCardFinder, findsOneWidget);

      // Pokemon summary widget expect
      expect(pokemonSummaryFinder, findsOneWidget);
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescripitonFinder, findsOneWidget);
      expect(pokemonTypesFinder, findsNWidgets(2));
      expect(pokemonTypesNameTypesFinder, findsOneWidget);
      expect(pokemonTypesNameExampleFinder, findsOneWidget);

      // Pokemon display widget expect
      expect(pokemonDisplayFinder, findsOneWidget);
      expect(pokemonCrystalCardFinder, findsOneWidget);
      expect(pokemonImageFinder, findsOneWidget);
    }),
  );
}
