import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_mobile_view.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_evolution_tree_widget.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_information_widget.dart';

import 'pokemon_details_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);

  testWidgets(
    'Show pokemon details mobile view - Details tab selected',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonDetailsMobileView(
            pokemonDetails: pokemonDetailsViewModelEmpty,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonInformationDetailsTextFinder = find.text('Detalles');
      final pokemonInformationDetailsEvolutionTextFinder =
          find.text('Evoluciones');
      final pokemonInformationFinder = find.byType(PokemonInformation);
      final pokemonEvolutionTreeFinder =
          find.byType(PokemonEvolutionTreeWidget);

      // Pokemon detilas widget expect
      expect(pokemonInformationDetailsTextFinder, findsOneWidget);
      expect(pokemonInformationDetailsEvolutionTextFinder, findsOneWidget);
      expect(pokemonInformationFinder, findsOneWidget);
      expect(pokemonEvolutionTreeFinder, findsNothing);
    },
  );

  testWidgets(
    'Show pokemon details mobile view - Evolution tab selected',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonDetailsMobileView(
            pokemonDetails: pokemonDetailsViewModelEmpty,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonInformationDetailsTextFinder = find.text('Detalles');
      final pokemonInformationDetailsEvolutionTextFinder =
          find.text('Evoluciones');
      final pokemonInformationFinder = find.byType(PokemonInformation);
      final pokemonEvolutionTreeFinder =
          find.byType(PokemonEvolutionTreeWidget);

      // Pokemon details widget actions
      await widgetTester.tap(pokemonInformationDetailsEvolutionTextFinder);
      await widgetTester.pumpAndSettle();

      // Pokemon details widget expect
      expect(pokemonInformationDetailsTextFinder, findsOneWidget);
      expect(pokemonInformationDetailsEvolutionTextFinder, findsOneWidget);
      expect(pokemonInformationFinder, findsNothing);
      expect(pokemonEvolutionTreeFinder, findsOneWidget);
    },
  );
}
