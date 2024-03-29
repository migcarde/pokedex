import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_specie_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonSpecie extends BaseUseCase<PokemonSpecieBusiness, String> {
  final PokedexRepository pokedexRepository;

  GetPokemonSpecie({required this.pokedexRepository});

  @override
  Future<PokemonSpecieBusiness> call(String params) =>
      pokedexRepository.getPokemonSpecie(params);
}
