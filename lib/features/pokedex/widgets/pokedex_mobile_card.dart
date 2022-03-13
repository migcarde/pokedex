import 'package:flutter/material.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';

class PokedexMobileCard extends StatelessWidget {
  const PokedexMobileCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  static const double pokemonBoxPositioned = -30.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.veryLargeDimen,
        right: Dimens.veryLargeDimen,
        top: Dimens.veryLargeDimen,
      ),
      decoration: BoxDecorationStyles.crystal(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PokemonSummary(pokemon: pokemon),
          Positioned(
            top: pokemonBoxPositioned,
            right: pokemonBoxPositioned,
            child: PokemonDisplay(
              picture: pokemon.picture,
            ),
          ),
        ],
      ),
    );
  }
}
