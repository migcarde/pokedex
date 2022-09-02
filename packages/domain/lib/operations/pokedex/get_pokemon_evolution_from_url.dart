import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonEvolutionFromUrl
    extends BaseUseCase<PokemonEvolutionBusiness, String> {
  final PokedexRepository pokedexRepository;

  GetPokemonEvolutionFromUrl({required this.pokedexRepository});

  //! TODO: Add test cases
  @override
  Future<PokemonEvolutionBusiness> call(String params) =>
      pokedexRepository.getPokemonEvolutionsFromUrl(params);
}
