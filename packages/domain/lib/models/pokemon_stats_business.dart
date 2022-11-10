import 'package:data/models/pokemon_stats_hive_model.dart';
import 'package:equatable/equatable.dart';

enum PokemonStatsTypeBusiness {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
  speed,
}

extension PokemonStatsTypeBusinessExtensions on PokemonStatsTypeBusiness {
  PokemonStatsTypeHiveModel toHiveModel() {
    switch (this) {
      case PokemonStatsTypeBusiness.hp:
        return PokemonStatsTypeHiveModel.hp;
      case PokemonStatsTypeBusiness.attack:
        return PokemonStatsTypeHiveModel.attack;
      case PokemonStatsTypeBusiness.defense:
        return PokemonStatsTypeHiveModel.defense;
      case PokemonStatsTypeBusiness.specialAttack:
        return PokemonStatsTypeHiveModel.specialAttack;
      case PokemonStatsTypeBusiness.specialDefense:
        return PokemonStatsTypeHiveModel.specialDefense;
      case PokemonStatsTypeBusiness.speed:
        return PokemonStatsTypeHiveModel.speed;
    }
  }
}

class PokemonStatsBusiness extends Equatable {
  final PokemonStatsTypeBusiness type;
  final int value;

  const PokemonStatsBusiness({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}

extension PokemonStatsBusinessExtensions on PokemonStatsBusiness {
  PokemonStatsHiveModel toHiveModel() => PokemonStatsHiveModel(
        type: type.toHiveModel(),
        value: value,
      );
}
