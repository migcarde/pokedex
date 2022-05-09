import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';

const pokemonStatsViewModelHpMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.hp,
  value: 0,
);

const pokemonStatsViewModelAttackMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.attack,
  value: 1,
);

const pokemonStatsViewModelDefenseMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.defense,
  value: 2,
);

const pokemonStatsViewModelSpecialAttackMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.specialAttack,
  value: 3,
);

const pokemonStatsViewModelSpecialDefenseMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.specialDefense,
  value: 4,
);

const pokemonStatsViewModelSpeedMock = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.speed,
  value: 5,
);

const pokemonStatsViewModelList = [
  pokemonStatsViewModelHpMock,
  pokemonStatsViewModelAttackMock,
  pokemonStatsViewModelDefenseMock,
  pokemonStatsViewModelSpecialAttackMock,
  pokemonStatsViewModelSpecialDefenseMock,
  pokemonStatsViewModelSpeedMock,
];
