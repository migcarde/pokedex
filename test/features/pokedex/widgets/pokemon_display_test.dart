import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';

void main() {
  testWidgets('Show pokemon display', ((WidgetTester tester) async {
    //! TODO: Check how to mock http to respond 200 OK
    //HttpOverrides.runZoned(() => null, createHttpClient: (p0) => MockHtt,);
    await tester.pumpWidget(
      const PokemonDisplay(
        picture: 'test',
      ),
    );

    final crystalCardFinder = find.byType(PokemonDisplay);

    expect(crystalCardFinder, findsOneWidget);
  }));
}
