import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonEvolutionsFromUrl
    extends BaseUseCase<PokemonEvolutionBusiness, String> {
  final PokedexRepository pokedexRepository;

  GetPokemonEvolutionsFromUrl({required this.pokedexRepository});

  @override
  Future<PokemonEvolutionBusiness> call(String params) =>
      pokedexRepository.getPokemonEvolutionsFromUrl(params);
}
