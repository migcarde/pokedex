import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_desktop_card.dart';

class PokedexDesktopView extends StatelessWidget {
  const PokedexDesktopView({
    Key? key,
    required this.pokemons,
    required this.getMorePokemons,
  }) : super(key: key);

  final List<PokedexViewModel> pokemons;
  final VoidCallback getMorePokemons;

  static const _sliverGridMaxCrossAxisExtent = 500.0;
  static const _sliverGridAspectRatio = 2.8;
  static const _itemPaddingBottom = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: _sliverGridMaxCrossAxisExtent,
          childAspectRatio: _sliverGridAspectRatio,
        ),
        padding: const EdgeInsets.only(bottom: _itemPaddingBottom),
        itemCount: pokemons.length + 1,
        controller: _setupScrollController(),
        itemBuilder: (BuildContext context, index) {
          if (index == pokemons.length) {
            return Container(
              margin: const EdgeInsets.only(
                left: Dimens.veryLargeDimen,
                right: Dimens.veryLargeDimen,
                top: Dimens.veryLargeDimen,
              ),
              width: Dimens.cardWidthDimen,
              height: Dimens.cardHeightDimen,
              child: Center(
                child: Image.asset(
                  'assets/pokemon_loader.gif',
                  height: Dimens.veryLargeDimen,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }

          final pokemon = pokemons[index];

          return PokedexDesktopCard(pokemon: pokemon);
        },
      ),
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
