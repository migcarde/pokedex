import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonDetailsById extends BaseUseCase<PokemonDetailsBusiness, int> {
  final PokedexRepository pokedexRepository;

  GetPokemonDetailsById({required this.pokedexRepository});

  @override
  Future<PokemonDetailsBusiness> call(int params) =>
      pokedexRepository.getPokemonById(params);
}
