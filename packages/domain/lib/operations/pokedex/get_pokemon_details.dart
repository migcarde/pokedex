import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonDetails extends BaseUseCase<PokemonDetailsBusiness, String> {
  final PokedexRepository pokedexRepository;

  GetPokemonDetails({required this.pokedexRepository});

  @override
  Future<PokemonDetailsBusiness> call(String params) =>
      pokedexRepository.getPokemon(params);
}
