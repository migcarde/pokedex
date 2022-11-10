import 'package:equatable/equatable.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';
import 'package:pokedex/features/pokemon_details/pokemon_evolution_view_model.dart';

class PokemonDetailsViewModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final List<PokemonStatsViewModel> stats;
  final String backPicture;
  final String frontPicture;
  final List<PokemonEvolutionViewModel> evolutions;
  final List<PokemonTypes> types;

  const PokemonDetailsViewModel({
    required this.id,
    required this.name,
    required this.description,
    required this.stats,
    required this.backPicture,
    required this.frontPicture,
    required this.evolutions,
    required this.types,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        stats,
        backPicture,
        frontPicture,
        evolutions,
        types,
      ];
}
