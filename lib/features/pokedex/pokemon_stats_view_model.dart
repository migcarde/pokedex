import 'package:domain/models/pokemon_stats_business.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex/common/pokemon_stats_colors.dart';
import 'package:pokedex/common/svg_icons.dart';

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
  final LocalSvgIcons icon;
  final Color contentColor;
  final Color backgroundColor;

  const PokemonStatsViewModel({
    required this.type,
    required this.value,
    required this.icon,
    required this.contentColor,
    required this.backgroundColor,
  });
}

extension PokemonStatsViewModelExtensions on PokemonStatsViewModel {
  PokemonStatsBusiness toBusiness() => PokemonStatsBusiness(
        type: type.toBusinesss(),
        value: value,
      );
}

extension PokemonStatsBusinessViewExtensions on PokemonStatsBusiness {
  PokemonStatsViewModel toViewModel() {
    switch (type) {
      case PokemonStatsTypeBusiness.hp:
        return PokemonStatsViewModel(
          type: PokemonStatsTypeViewModel.hp,
          value: value,
          icon: LocalSvgIcons.hp,
          contentColor: PokemonStatsColors.hpContent,
          backgroundColor: PokemonStatsColors.hpBackground,
        );
      case PokemonStatsTypeBusiness.attack:
        return PokemonStatsViewModel(
          type: PokemonStatsTypeViewModel.attack,
          value: value,
          icon: LocalSvgIcons.attack,
          contentColor: PokemonStatsColors.attackContent,
          backgroundColor: PokemonStatsColors.attackBackground,
        );
      case PokemonStatsTypeBusiness.defense:
        return PokemonStatsViewModel(
          type: PokemonStatsTypeViewModel.defense,
          value: value,
          icon: LocalSvgIcons.defense,
          contentColor: PokemonStatsColors.defenseContent,
          backgroundColor: PokemonStatsColors.defenseBackground,
        );
      case PokemonStatsTypeBusiness.specialAttack:
        return PokemonStatsViewModel(
          type: PokemonStatsTypeViewModel.specialAttack,
          value: value,
          icon: LocalSvgIcons.specialAttack,
          contentColor: PokemonStatsColors.specialAttackContent,
          backgroundColor: PokemonStatsColors.specialAttackBackground,
        );
      case PokemonStatsTypeBusiness.specialDefense:
        return PokemonStatsViewModel(
          type: PokemonStatsTypeViewModel.specialDefense,
          value: value,
          icon: LocalSvgIcons.specialDefense,
          contentColor: PokemonStatsColors.specialDefenseContent,
          backgroundColor: PokemonStatsColors.specialDefenseBackground,
        );
      case PokemonStatsTypeBusiness.speed:
        return PokemonStatsViewModel(
          type: PokemonStatsTypeViewModel.speed,
          value: value,
          icon: LocalSvgIcons.speed,
          contentColor: PokemonStatsColors.speedContent,
          backgroundColor: PokemonStatsColors.speedBackground,
        );
    }
  }
}
