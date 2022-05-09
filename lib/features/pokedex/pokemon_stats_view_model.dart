import 'package:domain/models/pokemon_stats_business.dart';

enum PokemonStatsTypeViewModel {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
  speed,
}

extension PokemonStatsTypeViewModelExtensions on PokemonStatsTypeViewModel {
  PokemonStatsTypeBusiness toBusinesss() {
    switch (this) {
      case PokemonStatsTypeViewModel.hp:
        return PokemonStatsTypeBusiness.hp;
      case PokemonStatsTypeViewModel.attack:
        return PokemonStatsTypeBusiness.attack;
      case PokemonStatsTypeViewModel.defense:
        return PokemonStatsTypeBusiness.defense;
      case PokemonStatsTypeViewModel.specialAttack:
        return PokemonStatsTypeBusiness.specialAttack;
      case PokemonStatsTypeViewModel.specialDefense:
        return PokemonStatsTypeBusiness.specialDefense;
      case PokemonStatsTypeViewModel.speed:
        return PokemonStatsTypeBusiness.speed;
    }
  }
}

extension PokemonStatsTypeBusinessExtensions on PokemonStatsTypeBusiness {
  PokemonStatsTypeViewModel toViewModel() {
    switch (this) {
      case PokemonStatsTypeBusiness.hp:
        return PokemonStatsTypeViewModel.hp;
      case PokemonStatsTypeBusiness.attack:
        return PokemonStatsTypeViewModel.attack;
      case PokemonStatsTypeBusiness.defense:
        return PokemonStatsTypeViewModel.defense;
      case PokemonStatsTypeBusiness.specialAttack:
        return PokemonStatsTypeViewModel.specialAttack;
      case PokemonStatsTypeBusiness.specialDefense:
        return PokemonStatsTypeViewModel.specialDefense;
      case PokemonStatsTypeBusiness.speed:
        return PokemonStatsTypeViewModel.speed;
    }
  }
}

class PokemonStatsViewModel {
  final PokemonStatsTypeViewModel type;
  final int value;

  const PokemonStatsViewModel({
    required this.type,
    required this.value,
  });
}

extension PokemonStatsViewModelExtensions on PokemonStatsViewModel {
  PokemonStatsBusiness toBusiness() => PokemonStatsBusiness(
        type: type.toBusinesss(),
        value: value,
      );
}

extension PokemonStatsBusinessViewExtensions on PokemonStatsBusiness {
  PokemonStatsViewModel toViewModel() => PokemonStatsViewModel(
        type: type.toViewModel(),
        value: value,
      );
}
