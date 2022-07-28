import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

import 'pokemon_stats_type_mock.dart';

const pokedexViewModelComplete = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [PokemonTypes.bug],
  stats: pokemonStatsViewModelList,
  evolutionChain: 'evolution chain',
  pokemonForm: 'pokemon form',
);

const pokedexViewModelTypesAndStatsEmpty = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  stats: [],
  evolutionChain: 'evolution chain',
  pokemonForm: 'pokemon form',
);

const pokedexViewModelCompleteTwoTags = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [PokemonTypes.bug, PokemonTypes.dragon],
  stats: [],
  evolutionChain: 'evolution chain',
  pokemonForm: 'pokemon form',
);

const pokedexViewModelHpStat = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  stats: [pokemonStatsViewModelHpMock],
  evolutionChain: 'evolution chain',
  pokemonForm: 'pokemon form',
);

const pokedexViewModelHpAndAttackStats = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  stats: [
    pokemonStatsViewModelHpMock,
    pokemonStatsViewModelAttackMock,
  ],
  evolutionChain: 'evolution chain',
  pokemonForm: 'pokemon form',
);

const pokedexViewModelList = [
  pokedexViewModelComplete,
  pokedexViewModelCompleteTwoTags,
  pokedexViewModelTypesAndStatsEmpty,
];
