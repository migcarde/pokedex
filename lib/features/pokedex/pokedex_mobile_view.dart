import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_mobile_card.dart';

class PokedexMobileView extends StatelessWidget {
  const PokedexMobileView({
    Key? key,
    required this.pokemons,
    required this.getMorePokemons,
  }) : super(key: key);

  final List<PokedexViewModel> pokemons;
  final VoidCallback getMorePokemons;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        controller: _setupScrollController(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index >= pokemons.length) {
            return Padding(
              padding: const EdgeInsets.only(top: Dimens.bigDimen),
              child: Image.asset(
                'assets/pokemon_loader.gif',
                height: Dimens.veryLargeDimen,
                fit: BoxFit.contain,
              ),
            );
          } else {
            final pokemon = pokemons[index];

            return PokedexMobileCard(pokemon: pokemon);
          }
        },
        itemCount: pokemons.length + 1,
      ),
    );
  }

  ScrollController _setupScrollController() {
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        getMorePokemons();
      }
    });

    return scrollController;
  }
}
