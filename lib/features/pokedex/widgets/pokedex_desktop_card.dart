import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';

class PokedexDesktopCard extends StatelessWidget {
  const PokedexDesktopCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  static const double cardDimen = 400.0;
  static const double blurSigma = 40.0;
  static const double boxOpacity = 0.2;
  static const double pokemonBoxPositioned = -30.0;
  static const double pokemonPictureDimen = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: veryLargeDimen,
        right: veryLargeDimen,
        top: veryLargeDimen,
      ),
      width: cardDimen,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(mediumDimen),
        ),
        color: Colors.black.withOpacity(boxOpacity),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PokemonSummary(pokemon: pokemon),
          Positioned.fill(
            top: pokemonBoxPositioned,
            child: Align(
              alignment: Alignment.topCenter,
              child: PokemonDisplay(
                picture: pokemon.picture,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
