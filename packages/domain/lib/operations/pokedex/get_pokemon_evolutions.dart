import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonEvolutions extends BaseUseCase<PokemonEvolutionBusiness, int> {
  final PokedexRepository pokedexRepository;

  GetPokemonEvolutions({required this.pokedexRepository});

  @override
  Future<PokemonEvolutionBusiness> call(int params) =>
      pokedexRepository.getPokemonEvolutions(params);
}
