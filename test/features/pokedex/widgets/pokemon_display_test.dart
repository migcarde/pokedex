import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';

void main() {
  //* Allows Network.image to make requests
  setUpAll(() => HttpOverrides.global = null);

  testWidgets(
    'Show pokemon display',
    ((WidgetTester tester) async {
      await tester.pumpWidget(
        const PokemonDisplay(
          picture:
              'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
        ),
      );

      final crystalCardFinder = find.byType(PokemonDisplay);
      final imageFinder = find.byType(Image);

      expect(crystalCardFinder, findsOneWidget);
      expect(imageFinder, findsOneWidget);
    }),
  );
}
