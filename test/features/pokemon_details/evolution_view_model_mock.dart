import 'package:pokedex/features/pokemon_details/pokemon_evolution_view_model.dart';

const evolutionWithoutEvolution = PokemonEvolutionViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolvesTo: [],
);

const evolutionWithEvolution = PokemonEvolutionViewModel(
  name: 'evolution',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  evolvesTo: [evolutionWithoutEvolution],
);
