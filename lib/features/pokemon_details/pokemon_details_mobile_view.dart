import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_view_model.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_evolution_tree_widget.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_information_widget.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class PokemonDetailsMobileView extends StatelessWidget {
  const PokemonDetailsMobileView({
    Key? key,
    required this.pokemonDetails,
  }) : super(key: key);

  final PokemonDetailsViewModel pokemonDetails;

  static const double _sizedBoxHeight = 550.0;
  static const double _detailsPaddingTop = 20.0;
  static const int _tabsLength = 2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: _sizedBoxHeight,
        child: CrystalCard(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.bigDimen),
            child: DefaultTabController(
              length: _tabsLength,
              child: Column(
                children: [
                  SizedBox(
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyles.bold(),
                      labelColor: Colors.white,
                      tabs: const [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Tab(text: 'Detalles'),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Tab(text: 'Evoluciones'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: _detailsPaddingTop),
                          child: PokemonInformation(
                            pokemonDetails: pokemonDetails,
                          ),
                        ),
                        PokemonEvolutionTreeWidget(
                          evolutions: pokemonDetails.evolutions,
                        ),
                      ],
                    ),
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
