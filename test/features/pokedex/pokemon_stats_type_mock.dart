import 'package:pokedex/common/pokemon_stats_colors.dart';
import 'package:pokedex/common/svg_icons.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';

const pokemonStatsViewModelHpMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.hp,
  value: 0,
  icon: LocalSvgIcons.hp,
  contentColor: PokemonStatsColors.hpContent,
  backgroundColor: PokemonStatsColors.hpBackground,
);

const pokemonStatsViewModelAttackMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.attack,
  value: 1,
  icon: LocalSvgIcons.attack,
  contentColor: PokemonStatsColors.attackContent,
  backgroundColor: PokemonStatsColors.attackBackground,
);

const pokemonStatsViewModelDefenseMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.defense,
  value: 2,
  icon: LocalSvgIcons.defense,
  contentColor: PokemonStatsColors.defenseContent,
  backgroundColor: PokemonStatsColors.defenseBackground,
);

const pokemonStatsViewModelSpecialAttackMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.specialAttack,
  value: 3,
  icon: LocalSvgIcons.specialAttack,
  contentColor: PokemonStatsColors.specialAttackContent,
  backgroundColor: PokemonStatsColors.specialAttackBackground,
);

const pokemonStatsViewModelSpecialDefenseMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.specialDefense,
  value: 4,
  icon: LocalSvgIcons.specialDefense,
  contentColor: PokemonStatsColors.specialDefenseContent,
  backgroundColor: PokemonStatsColors.specialDefenseBackground,
);

const pokemonStatsViewModelSpeedMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.speed,
  value: 5,
  icon: LocalSvgIcons.speed,
  contentColor: PokemonStatsColors.speedContent,
  backgroundColor: PokemonStatsColors.speedBackground,
);

const pokemonStatsViewModelList = [
  pokemonStatsViewModelHpMock,
  pokemonStatsViewModelAttackMock,
  pokemonStatsViewModelDefenseMock,
  pokemonStatsViewModelSpecialAttackMock,
  pokemonStatsViewModelSpecialDefenseMock,
  pokemonStatsViewModelSpeedMock,
];
