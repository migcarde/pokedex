import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';
import 'package:pokedex/features/pokemon_details/widgets/pokemon_stat_information.dart';

class PokemonStatsContent extends StatelessWidget {
  const PokemonStatsContent({Key? key, required this.stats}) : super(key: key);

  final List<PokemonStatsViewModel> stats;

  static const _spacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      direction: Axis.horizontal,
      spacing: _spacing,
      children: stats
          .map(
            (stat) => PokemonStatInformation(
              backgroundColor: stat.backgroundColor,
              icon: stat.icon,
              contentColor: stat.contentColor,
              value: stat.value.toString(),
            ),
          )
          .toList(),
    );
  }
}
