import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_evolution_tree_widget.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_sprite_widget.dart';

import '../evolution_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);
  testWidgets(
    'Show pokemon evolution tree widget - No evolutions',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonEvolutionTreeWidget(
            evolutions: [evolutionWithoutEvolution],
          ),
        ),
      );

      // Sprite widget finders
      final pokemonSpriteWidgetFinder = find.byType(PokemonSpriteWidget);
      final pokemonSpriteImageFinder = find.byType(Image);
      final pokemonSpriteNameFinder =
          find.text(evolutionWithoutEvolution.name.capitalize());

      // Evolution tree widget finders
      final pokemonEvolutionTreeWidgetFinder =
          find.byType(PokemonEvolutionTreeWidget);

      // Sprite widget expect
      expect(pokemonSpriteWidgetFinder, findsOneWidget);
      expect(pokemonSpriteImageFinder, findsOneWidget);
      expect(pokemonSpriteNameFinder, findsOneWidget);

      // Evolution tree widget expect
      expect(pokemonEvolutionTreeWidgetFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Show pokemon evolution tree widget - With evolutions',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonEvolutionTreeWidget(
            evolutions: [evolutionWithEvolution],
          ),
        ),
      );

      // Sprite widget finders
      final pokemonSpriteWidgetFinder = find.byType(PokemonSpriteWidget);
      final pokemonSpriteImageFinder = find.byType(Image);
      final pokemonSpriteNameFinder =
          find.text(evolutionWithoutEvolution.name.capitalize());
      final pokemonEvolutionSpriteNameFinder =
          find.text(evolutionWithEvolution.name.capitalize());

      // Evolution tree widget finders
      final pokemonEvolutionTreeWidgetFinder =
          find.byType(PokemonEvolutionTreeWidget);

      // Sprite widget expect
      expect(pokemonSpriteWidgetFinder, findsNWidgets(2));
      expect(pokemonSpriteImageFinder, findsNWidgets(2));
      expect(pokemonSpriteNameFinder, findsOneWidget);
      expect(pokemonEvolutionSpriteNameFinder, findsOneWidget);

      // Evolution tree widget expect
      expect(pokemonEvolutionTreeWidgetFinder, findsNWidgets(2));
    },
  );
}
