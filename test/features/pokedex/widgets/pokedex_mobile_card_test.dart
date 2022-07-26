import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_mobile_card.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';

import '../pokedex_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Show pokemon mobile card', ((WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PokedexMobileCard(
          pokemon: pokedexViewModelComplete,
        ),
      ),
    );

    final pokedexMobileCardFinder = find.byType(PokedexMobileCard);

    expect(pokedexMobileCardFinder, findsOneWidget);

    // Summary widget finders
    final pokemonSummaryFinder = find.byType(PokemonSummary);
    final pokemonNameFinder = find.text('Name');
    final pokemonDescripitonFinder = find.text('Description');
    final pokemonTypesFinder = find.byType(PokemonType);
    final pokemonTypesNameFinder = find.text('Bug');

    // Pokemon display widget finders
    final pokemonDisplayFinder = find.byType(PokemonDisplay);
    final pokemonCrystalCardFinder = find.byType(PokemonDisplay);
    final pokemonImageFinder = find.byType(Image);

    expect(pokedexMobileCardFinder, findsOneWidget);

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
  }));
}
