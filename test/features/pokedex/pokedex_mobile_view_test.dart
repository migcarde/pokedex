import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/pokedex_mobile_view.dart';

import 'pokedex_view_model_mock.dart';

void main() {
  testWidgets(
    'Show pokedex mobile view card with void callback',
    ((WidgetTester tester) async {
      //! TODO: Check how to mock http to respond 200 OK
      //HttpOverrides.runZoned(() => null, createHttpClient: (p0) => MockHtt,);
      await tester.pumpWidget(
        MaterialApp(
          home: PokedexMobileView(
            pokemons: pokedexViewModelList,
            getMorePokemons: () {},
          ),
        ),
      );

      final crystalCardFinder = find.byType(Image);

      expect(crystalCardFinder, findsOneWidget);
    }),
  );
}
