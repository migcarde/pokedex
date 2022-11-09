import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_view_model.dart';

import 'evolution_view_model_mock.dart';
import 'pokemon_stats_view_model_mock.dart';

const pokemonDetailsViewModelEmpty = PokemonDetailsViewModel(
  id: 1,
  name: 'name',
  description: 'description',
  stats: [],
  backPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  frontPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolutions: [],
  types: [],
);

const pokemonDetailsViewModelWithTwoStats = PokemonDetailsViewModel(
  id: 1,
  name: 'name',
  description: 'description',
  stats: [pokemonStats, pokemonStats],
  backPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  frontPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolutions: [],
  types: [],
);

const pokemonDetailsViewModelWithEvolutions = PokemonDetailsViewModel(
  id: 1,
  name: 'name',
  description: 'description',
  stats: [],
  backPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  frontPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolutions: [evolutionWithEvolution],
  types: [],
);

const pokemonDetailsViewModelWithTwoTypes = PokemonDetailsViewModel(
  id: 1,
  name: 'name',
  description: 'description',
  stats: [],
  backPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  frontPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolutions: [],
  types: [PokemonTypes.bug, PokemonTypes.dark],
);

const pokemonDetailsComplete = PokemonDetailsViewModel(
  id: 1,
  name: 'name',
  description: 'description',
  stats: [pokemonStats, pokemonStats],
  backPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  frontPicture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolutions: [evolutionWithEvolution],
  types: [PokemonTypes.bug, PokemonTypes.dark],
);
