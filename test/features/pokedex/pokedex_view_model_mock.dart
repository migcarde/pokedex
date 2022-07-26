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
);

const pokedexViewModelTypesAndStatsEmpty = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  stats: [],
);

const pokedexViewModelCompleteTwoTags = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [PokemonTypes.bug, PokemonTypes.dragon],
  stats: [],
);

const pokedexViewModelHpStat = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  stats: [pokemonStatsViewModelHpMock],
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
);

const pokedexViewModelList = [
  pokedexViewModelComplete,
  pokedexViewModelCompleteTwoTags,
  pokedexViewModelTypesAndStatsEmpty,
];
