import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stats_content.dart';
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
                  padding: const EdgeInsets.only(top: Dimens.mediumDimen),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Dimens.veryBigDimen,
                            ),
                            child: Text(
                              pokemon.name.capitalize(),
                              style: TextStyles.header(
                                textColor: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Dimens.mediumBigDimen,
                            ),
                            child: Text(
                              pokemon.description,
                              style: TextStyles.body(
                                textColor: Colors.white,
                              ),
                            ),
                          ),

                          PokemonStatsContent(stats: pokemon.stats),

                          //! TODO: Add pokemon stats widget (we have to create it)
                          //! TODO: Add pokemon evolutions card (could be easy to do using CrystalCard)
                        ],
                      ),
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
