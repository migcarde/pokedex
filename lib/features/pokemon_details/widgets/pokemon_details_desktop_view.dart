import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class PokemonDetailsDesktopView extends StatelessWidget {
  const PokemonDetailsDesktopView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  static const double _sizedBoxWidth = 700.0;
  static const double _sizedBoxHeight = 400.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: _sizedBoxWidth,
            height: _sizedBoxHeight,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.tinyLargeDimen),
              child: CrystalCard(
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimens.largeDimen),
                  child: Column(
                    children: [
                      Text(pokemon.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: pokemon.types
                            .map(
                              (type) => PokemonType(
                                type: type,
                              ),
                            )
                            .toList(),
                      ),
                      Text(pokemon.description),

                      //! TODO: Add pokemon stats widget (we have to create it)
                      //! Add pokemon evolutions card (could be easy to do using CrystalCard)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
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
