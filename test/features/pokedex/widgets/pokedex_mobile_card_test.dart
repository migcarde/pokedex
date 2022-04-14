import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_desktop_card.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';

import '../pokedex_view_model_mock.dart';

void main() {
  testWidgets('Show pokemon mobile card', ((WidgetTester tester) async {
    //! TODO: Check how to mock http to respond 200 OK
    //HttpOverrides.runZoned(() => null, createHttpClient: (p0) => MockHtt,);
    await tester.pumpWidget(
      const MaterialApp(
        home: PokedexDesktopCard(
          pokemon: pokedexViewModelComplete,
        ),
      ),
    );

    final crystalCardFinder = find.byType(PokemonDisplay);

    expect(crystalCardFinder, findsOneWidget);
  }));
}
