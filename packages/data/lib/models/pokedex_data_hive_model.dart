import 'package:data/models/pokemon_stats_hive_model.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:hive/hive.dart';

part 'pokedex_data_hive_model.g.dart';

@HiveType(typeId: 0)
class PokedexDataHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String frontPicture;

  @HiveField(3)
  final String backPicture;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final List<String> types;

  @HiveField(6)
  final List<PokemonStatsHiveModel> stats;

  @HiveField(7)
  final String species;

  PokedexDataHiveModel({
    required this.id,
    required this.name,
    required this.frontPicture,
    required this.backPicture,
    required this.description,
    required this.types,
    required this.stats,
    required this.species,
  });
}

extension PokedexHiveModelParser on PokedexDataHiveModel {
  PokedexBusiness toDomain() => PokedexBusiness(
        id: id,
        name: name,
        frontPicture: frontPicture,
        backPicture: backPicture,
        description: description,
        types: types,
        stats: stats.map((stat) => stat.toDomain()).toList(),
        species: PokemonDetailsSpecieBusiness(
          url: species,
        ),
      );
}
