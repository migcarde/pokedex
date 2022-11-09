import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_desktop_view.dart';

import 'pokemon_details_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);

  testWidgets(
    'Show pokemon details desktop view - Pokemon details properties empty',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonDetailsDesktopView(
            pokemonDetails: pokemonDetailsViewModelEmpty,
          ),
        ),
      );
    },
  );
}
