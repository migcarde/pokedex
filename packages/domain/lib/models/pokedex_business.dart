import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:equatable/equatable.dart';

class PokedexBusiness extends Equatable {
  final int id;
  final String name;
  final String frontPicture;
  final String backPicture;
  final String description;
  final List<String> types;
  final List<PokemonStatsBusiness> stats;
  final PokemonDetailsSpecieBusiness species;

  const PokedexBusiness({
    required this.id,
    required this.name,
    required this.frontPicture,
    required this.backPicture,
    required this.description,
    required this.types,
    required this.stats,
    required this.species,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        frontPicture,
        backPicture,
        description,
        types,
        stats,
        species,
      ];
}

extension PokedexBusinessExtensions on PokedexBusiness {
  PokedexDataHiveModel toHiveModel() => PokedexDataHiveModel(
        id: id,
        name: name,
        frontPicture: frontPicture,
        backPicture: backPicture,
        description: description,
        types: types,
        stats: stats.map((stat) => stat.toHiveModel()).toList(),
        species: species.url,
      );
}
