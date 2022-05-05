import 'package:domain/models/pokemon_stats_business.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'pokemon_stats_hive_model.g.dart';

enum PokemonStatsTypeHiveModel {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
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
class PokemonStatsHiveModel extends Equatable {
  @HiveField(0)
  final PokemonStatsTypeHiveModel type;

  @HiveField(1)
  final int value;

  const PokemonStatsHiveModel({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}

extension PokemonStatsTypeModelParser on PokemonStatsHiveModel {
  PokemonStatsBusiness toDomain() => PokemonStatsBusiness(
        type: type.toDomain(),
        value: value,
      );
}
