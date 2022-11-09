import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/common/svg_icons.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stat_information.dart';

void main() {
  testWidgets('Show pokemon stat information widget', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PokemonStatInformation(
          backgroundColor: Colors.black,
          icon: LocalSvgIcons.attack,
          contentColor: Colors.white,
          value: '10',
        ),
      ),
    );

    // Pokemon stat finders
    final pokemonStatImageFinder = find.byType(SvgPicture);
    final pokemonStatTextFinder = find.text('10');

    // Pokemon stat widget expect
    expect(pokemonStatImageFinder, findsOneWidget);
    expect(pokemonStatTextFinder, findsOneWidget);
  });
}
