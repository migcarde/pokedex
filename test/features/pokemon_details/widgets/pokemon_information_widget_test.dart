import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_information_widget.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stat_information.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stats_content.dart';

import '../pokemon_details_view_model_mock.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);
  testWidgets(
    'Show pokemon information - Empty properties',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonInformation(
            pokemonDetails: pokemonDetailsViewModelEmpty,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('description');

      // Pokemon details type widget finders
      final pokemonTypeFinder = find.byType(PokemonType);

      // Pokemon details display widget finders
      final pokemonDetailsDisplay = find.byType(PokemonDisplay);

      // Pokemon details stats widget finders
      final pokemonStatsContentDisplay = find.byType(PokemonStatsContent);

      // Pokemon details widget expect
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);

      // Pokemon details type widget finders
      expect(pokemonTypeFinder, findsNothing);

      // Pokemon details display widget finders
      expect(pokemonDetailsDisplay, findsNWidgets(2));

      // Pokemon details stats widget finders
      expect(pokemonStatsContentDisplay, findsNothing);
    },
  );

  testWidgets(
    'Show pokemon information - Two stats',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonInformation(
            pokemonDetails: pokemonDetailsViewModelWithTwoStats,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('description');

      // Pokemon details type widget finders
      final pokemonTypeFinder = find.byType(PokemonType);

      // Pokemon details display widget finders
      final pokemonDetailsDisplay = find.byType(PokemonDisplay);

      // Pokemon details stats widget finders
      final pokemonStatsContentDisplay = find.byType(PokemonStatsContent);
      final pokemonStatInformationFinder = find.byType(PokemonStatInformation);
      final pokemonStatInformationPictureFinder = find.byType(SvgPicture);
      final pokemonStatTextFinder = find.text('10');

      // Pokemon details widget expect
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);

      // Pokemon details type widget finders
      expect(pokemonTypeFinder, findsNothing);

      // Pokemon details display widget finders
      expect(pokemonDetailsDisplay, findsNWidgets(2));

      // Pokemon details stats widget finders
      expect(pokemonStatsContentDisplay, findsOneWidget);
      expect(pokemonStatInformationFinder, findsNWidgets(2));
      expect(pokemonStatInformationPictureFinder, findsNWidgets(2));
      expect(pokemonStatTextFinder, findsNWidgets(2));
    },
  );

  testWidgets(
    'Show pokemon information - Types properties',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonInformation(
            pokemonDetails: pokemonDetailsViewModelWithTwoTypes,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('description');

      // Pokemon details type widget finders
      final pokemonTypeFinder = find.byType(PokemonType);
      final pokemonTypeNameBugFinder = find.text('Bug');
      final pokemonTypeNameDarkFinder = find.text('Dark');

      // Pokemon details display widget finders
      final pokemonDetailsDisplay = find.byType(PokemonDisplay);

      // Pokemon details stats widget finders
      final pokemonStatsContentDisplay = find.byType(PokemonStatsContent);

      // Pokemon details widget expect
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);

      // Pokemon details type widget finders
      expect(pokemonTypeFinder, findsNWidgets(2));
      expect(pokemonTypeNameBugFinder, findsOneWidget);
      expect(pokemonTypeNameDarkFinder, findsOneWidget);

      // Pokemon details display widget finders
      expect(pokemonDetailsDisplay, findsNWidgets(2));

      // Pokemon details stats widget finders
      expect(pokemonStatsContentDisplay, findsNothing);
    },
  );

  testWidgets(
    'Show pokemon information - All properties',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: PokemonInformation(
            pokemonDetails: pokemonDetailsComplete,
          ),
        ),
      );

      // Pokemon details widget finders
      final pokemonNameFinder = find.text('Name');
      final pokemonDescriptionFinder = find.text('description');

      // Pokemon details type widget finders
      final pokemonTypeFinder = find.byType(PokemonType);
      final pokemonTypeNameBugFinder = find.text('Bug');
      final pokemonTypeNameDarkFinder = find.text('Dark');

      // Pokemon details display widget finders
      final pokemonDetailsDisplay = find.byType(PokemonDisplay);

      // Pokemon details stats widget finders
      final pokemonStatsContentDisplay = find.byType(PokemonStatsContent);
      final pokemonStatInformationFinder = find.byType(PokemonStatInformation);
      final pokemonStatInformationPictureFinder = find.byType(SvgPicture);
      final pokemonStatTextFinder = find.text('10');

      // Pokemon details widget expect
      expect(pokemonNameFinder, findsOneWidget);
      expect(pokemonDescriptionFinder, findsOneWidget);

      // Pokemon details type widget finders
      expect(pokemonTypeFinder, findsNWidgets(2));
      expect(pokemonTypeNameBugFinder, findsOneWidget);
      expect(pokemonTypeNameDarkFinder, findsOneWidget);

      // Pokemon details display widget finders
      expect(pokemonDetailsDisplay, findsNWidgets(2));

      // Pokemon details stats widget finders
      expect(pokemonStatsContentDisplay, findsOneWidget);
      expect(pokemonStatInformationFinder, findsNWidgets(2));
      expect(pokemonStatInformationPictureFinder, findsNWidgets(2));
      expect(pokemonStatTextFinder, findsNWidgets(2));
    },
  );
}
