import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stats_content.dart';

import '../pokemon_stats_view_model_mock.dart';

void main() {
  testWidgets('Show pokemon stats widget - One stat', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PokemonStatsContent(
          stats: [pokemonStats],
        ),
      ),
    );

    // Pokemon stat finders
    final pokemonStatImageFinder = find.byType(SvgPicture);
    final pokemonStatTextFinder = find.text(pokemonStats.value.toString());

    // Pokemon stat widget expect
    expect(pokemonStatImageFinder, findsOneWidget);
    expect(pokemonStatTextFinder, findsOneWidget);
  });

  testWidgets('Show pokemon stats widget - Two stats', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PokemonStatsContent(
          stats: [pokemonStats, pokemonStats],
        ),
      ),
    );

    // Pokemon stat finders
    final pokemonStatImageFinder = find.byType(SvgPicture);
    final pokemonStatTextFinder = find.text(pokemonStats.value.toString());

    // Pokemon stat widget expect
    expect(pokemonStatImageFinder, findsNWidgets(2));
    expect(pokemonStatTextFinder, findsNWidgets(2));
  });
}
