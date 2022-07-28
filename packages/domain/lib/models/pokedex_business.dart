import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:equatable/equatable.dart';

class PokedexBusiness extends Equatable {
  final String name;
  final String picture;
  final String description;
  final List<String> types;
  final List<PokemonStatsBusiness> stats;
  final String evolutionChain;
  final String pokemonForm;

  const PokedexBusiness({
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
    required this.stats,
    required this.evolutionChain,
    required this.pokemonForm,
  });

  @override
  List<Object?> get props => [
        name,
        picture,
        description,
        types,
        stats,
        evolutionChain,
        pokemonForm,
      ];
}

extension PokedexBusinessExtensions on PokedexBusiness {
  PokedexDataHiveModel toHiveModel() => PokedexDataHiveModel(
        name: name,
        picture: picture,
        description: description,
        types: types,
        stats: stats.map((stat) => stat.toHiveModel()).toList(),
        evolutionChain: evolutionChain,
        pokemonForm: pokemonForm,
      );
}
