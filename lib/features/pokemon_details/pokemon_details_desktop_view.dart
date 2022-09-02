import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_view_model.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_evolution_tree_widget.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stats_content.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class PokemonDetailsDesktopView extends StatelessWidget {
  const PokemonDetailsDesktopView({
    Key? key,
    required this.pokemonDetails,
  }) : super(key: key);

  final PokemonDetailsViewModel pokemonDetails;

  static const double _sizedBoxWidth = 700.0;
  static const double _sizedBoxHeight = 520.0;
  static const double _pokemonSpriteSize = 100.0;
  static const double _dividerWidth = 0.1;
  static const double _dividerHeight = 400.0;
  static const double _evolutionsHeight = 380.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _sizedBoxWidth,
        height: _sizedBoxHeight,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.tinyLargeDimen),
          child: CrystalCard(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.bigDimen),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              pokemonDetails.name.capitalize(),
                              style: TextStyles.header(
                                textColor: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: Dimens.mediumBigDimen,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: pokemonDetails.types
                                    .map(
                                      (type) => PokemonType(
                                        type: type,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: Dimens.mediumBigDimen,
                              ),
                              child: Text(
                                pokemonDetails.description,
                                style: TextStyles.body(
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Dimens.mediumDimen),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PokemonDisplay(
                                    picture: pokemonDetails.backPicture,
                                    pictureSize: _pokemonSpriteSize,
                                  ),
                                  PokemonDisplay(
                                    picture: pokemonDetails.frontPicture,
                                    pictureSize: _pokemonSpriteSize,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Dimens.mediumDimen),
                              child: PokemonStatsContent(
                                  stats: pokemonDetails.stats),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: _dividerWidth,
                        height: _dividerHeight,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimens.bigDimen),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Evolutions',
                              style: TextStyles.header(
                                textColor: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PokemonEvolutionTreeWidget(
                              evolutions: pokemonDetails.evolutions,
                              treeHeight: _evolutionsHeight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
