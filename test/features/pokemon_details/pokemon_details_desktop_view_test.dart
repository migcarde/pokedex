import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_desktop_view.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_evolution_tree_widget.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_information_widget.dart';

import 'pokemon_details_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);

  testWidgets(
    'Show pokemon details desktop view',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonDetailsDesktopView(
            pokemonDetails: pokemonDetailsViewModelEmpty,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonInformationFinder = find.byType(PokemonInformation);
      final pokemonInformationEvolutionTextFinder = find.text('Evolutions');
      final pokemonEvolutionTreeFinder =
          find.byType(PokemonEvolutionTreeWidget);

      // Pokemon detilas widget expect
      expect(pokemonInformationFinder, findsOneWidget);
      expect(pokemonInformationEvolutionTextFinder, findsOneWidget);
      expect(pokemonEvolutionTreeFinder, findsOneWidget);
    },
  );
}
