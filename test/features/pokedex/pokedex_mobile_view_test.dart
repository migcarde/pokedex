import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/pokedex_mobile_view.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_mobile_card.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/widgets/crystal_card.dart';

import 'pokedex_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);
  testWidgets(
    'Show pokedex mobile view card with void callback',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PokedexMobileView(
            pokemons: pokedexViewModelList,
            getMorePokemons: () {},
          ),
        ),
      );

      final crystalCardFinder = find.byType(CrystalCard);
      final imageFinder = find.byType(Image);

      // Pokedex mobile card widget finder
      final pokedexMobileCardFinder = find.byType(PokedexMobileCard);

      // Pokemon summary widget finder
      final pokemonSummaryWidgetFinder = find.byType(PokemonSummary);
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('Description');
      final pokemonTypeObjectFinder = find.byType(PokemonType);
      final pokemonTypeFinder = find.text('Bug');
      final pokemonTypeSecondFinder = find.text('Dragon');

      // Pokemon display widget finder
      final pokemonDisplayWidgetFinder = find.byType(PokemonDisplay);

      expect(crystalCardFinder, findsWidgets);
      expect(imageFinder, findsNWidgets(4));

      // Pokedex mobile card widget expect
      expect(pokedexMobileCardFinder, findsNWidgets(3));

      // Pokemon summary widget expect
      expect(pokemonSummaryWidgetFinder, findsNWidgets(3));
      expect(pokemonNameFinder, findsNWidgets(3));
      expect(pokemonDescriptionFinder, findsNWidgets(3));
      expect(pokemonTypeFinder, findsNWidgets(2));
      expect(pokemonTypeSecondFinder, findsOneWidget);
      expect(pokemonTypeObjectFinder, findsNWidgets(3));

      // Pokemon display widget expect
      expect(pokemonDisplayWidgetFinder, findsNWidgets(3));
    }),
  );
}
