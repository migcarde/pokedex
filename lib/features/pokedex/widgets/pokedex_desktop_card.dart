import 'package:flutter/material.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_summary.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_view.dart';

class PokedexDesktopCard extends StatelessWidget {
  const PokedexDesktopCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  static const double pokemonBoxPositioned = -30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) => PokemonDetailsView(
            pokemon: pokemon,
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
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
        ),
      ),
    );
  }
}
