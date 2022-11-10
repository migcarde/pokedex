import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

const pokedexViewModelComplete = PokedexViewModel(
  id: 1,
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [PokemonTypes.bug],
  species: 'species',
);

const pokedexViewModelTypesAndStatsEmpty = PokedexViewModel(
    id: 2,
    name: 'name',
    picture:
        'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
    description: 'description',
    types: [],
    species: 'species');

const pokedexViewModelCompleteTwoTags = PokedexViewModel(
  id: 1,
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [PokemonTypes.bug, PokemonTypes.dragon],
  species: 'species',
);

const pokedexViewModelHpStat = PokedexViewModel(
  id: 1,
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  species: 'species',
);

const pokedexViewModelHpAndAttackStats = PokedexViewModel(
  id: 1,
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
  species: 'species',
);

const pokedexViewModelList = [
  pokedexViewModelComplete,
  pokedexViewModelCompleteTwoTags,
  pokedexViewModelTypesAndStatsEmpty,
];
