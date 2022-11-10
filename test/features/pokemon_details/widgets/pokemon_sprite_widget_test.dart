import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_sprite_widget.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);
  testWidgets(
    'PokemonSprite widget test',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonSpriteWidget(
            pictureUrl:
                'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
            evolutionName: 'Evolution',
          ),
        ),
      );

      // Pokemon sprite finders
      final pokemonSpriteImageFinder = find.byType(Image);
      final pokemonSpriteTextFinder = find.text('Evolution');

      // Pokmemon sprite widget expect
      expect(pokemonSpriteImageFinder, findsOneWidget);
      expect(pokemonSpriteTextFinder, findsOneWidget);
    },
  );
}
