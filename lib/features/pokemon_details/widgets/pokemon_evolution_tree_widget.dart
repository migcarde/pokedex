import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/features/pokemon_details/pokemon_evolution_view_model.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_sprite_widget.dart';

class PokemonEvolutionTreeWidget extends StatelessWidget {
  const PokemonEvolutionTreeWidget({
    Key? key,
    required this.evolutions,
    this.treeHeight,
  }) : super(key: key);

  final List<PokemonEvolutionViewModel> evolutions;
  final double? treeHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: treeHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: evolutions
            .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PokemonSpriteWidget(
                        pictureUrl: e.picture, evolutionName: e.name),
                    if (e.evolvesTo.isNotEmpty)
                      PokemonEvolutionTreeWidget(
                        evolutions: e.evolvesTo,
                      )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
