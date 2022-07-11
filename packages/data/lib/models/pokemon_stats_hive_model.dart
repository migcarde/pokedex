import 'package:domain/models/pokemon_stats_business.dart';
import 'package:hive/hive.dart';

part 'pokemon_stats_hive_model.g.dart';

@HiveType(typeId: 2)
enum PokemonStatsTypeHiveModel {
  @HiveField(0)
  hp,
  @HiveField(1)
  attack,
  @HiveField(2)
  defense,
  @HiveField(3)
  specialAttack,
  @HiveField(4)
  specialDefense,
  @HiveField(5)
  speed,
}

extension PokemonStatsTypeHiveExtensions on PokemonStatsTypeHiveModel {
  PokemonStatsTypeBusiness toDomain() {
    switch (this) {
      case PokemonStatsTypeHiveModel.hp:
        return PokemonStatsTypeBusiness.hp;
      case PokemonStatsTypeHiveModel.attack:
        return PokemonStatsTypeBusiness.attack;
      case PokemonStatsTypeHiveModel.defense:
        return PokemonStatsTypeBusiness.defense;
      case PokemonStatsTypeHiveModel.specialAttack:
        return PokemonStatsTypeBusiness.specialAttack;
      case PokemonStatsTypeHiveModel.specialDefense:
        return PokemonStatsTypeBusiness.specialDefense;
      case PokemonStatsTypeHiveModel.speed:
        return PokemonStatsTypeBusiness.speed;
    }
  }
}

@HiveType(typeId: 1)
class PokemonStatsHiveModel extends HiveObject {
  @HiveField(0)
  final PokemonStatsTypeHiveModel type;

  @HiveField(1)
  final int value;

  PokemonStatsHiveModel({
    required this.type,
    required this.value,
  });
}

extension PokemonStatsTypeModelParser on PokemonStatsHiveModel {
  PokemonStatsBusiness toDomain() => PokemonStatsBusiness(
        type: type.toDomain(),
        value: value,
      );
}
