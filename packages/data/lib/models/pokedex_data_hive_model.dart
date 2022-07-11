import 'package:data/models/pokemon_stats_hive_model.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:hive/hive.dart';

part 'pokedex_data_hive_model.g.dart';

@HiveType(typeId: 0)
class PokedexDataHiveModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String picture;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<String> types;

  @HiveField(4)
  final List<PokemonStatsHiveModel> stats;

  PokedexDataHiveModel({
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
    required this.stats,
  });
}

extension PokedexHiveModelParser on PokedexDataHiveModel {
  PokedexBusiness toDomain() => PokedexBusiness(
        name: name,
        picture: picture,
        description: description,
        types: types,
        stats: stats.map((stat) => stat.toDomain()).toList(),
      );
}

// extension PokedexBusinessExtensions on PokedexBusiness {
//   PokedexDataHiveModel toHiveModel() => PokedexDataHiveModel(
//         name: name,
//         picture: picture,
//         description: description,
//         types: types,
//         stats: stats.map((stat) => stat.toHiveModel()).toList(),
//       );
// }

// extension ListExtensions<T> on List<T> {
//   HiveList<T> toHiveList() => HiveList(box)
// }