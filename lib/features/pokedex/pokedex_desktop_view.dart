import 'package:flutter/widgets.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_desktop_card.dart';

class PokedexDesktopView extends StatelessWidget {
  const PokedexDesktopView({
    Key? key,
    required this.pokemons,
    required this.hasNextPage,
    required this.getMorePokemons,
  }) : super(key: key);

  final List<PokedexViewModel> pokemons;
  final bool hasNextPage;
  final VoidCallback getMorePokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500.0,
        childAspectRatio: 6 / 2,
      ),
      itemCount: pokemons.length + 1,
      controller: _setupScrollController(),
      itemBuilder: (BuildContext context, index) {
        if (hasNextPage && index == pokemons.length) {
          return Container(
            margin: const EdgeInsets.only(
              left: veryLargeDimen,
              right: veryLargeDimen,
              top: veryLargeDimen,
            ),
            width: cardWidthDimen,
            height: cardHeightDimen,
            child: Center(
              child: Image.asset(
                'assets/pokemon_loader.gif',
                height: veryLargeDimen,
                fit: BoxFit.contain,
              ),
            ),
          );
        }

        final pokemon = pokemons[index];

        return PokedexDesktopCard(pokemon: pokemon);
      },
    );
  }

  ScrollController _setupScrollController() {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if ((scrollController.position.atEdge &&
          scrollController.position.pixels != 0)) {
        getMorePokemons();
      }
    });

    return scrollController;
  }
}
