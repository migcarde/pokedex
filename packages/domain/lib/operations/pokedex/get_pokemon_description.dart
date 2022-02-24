import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokemon_specie_busines.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokemonDescription extends BaseUseCase<PokemonSpecieBusiness, String> {
  final PokedexRepository pokedexRepository;

  GetPokemonDescription({required this.pokedexRepository});

  @override
  Future<PokemonSpecieBusiness> call(String params) =>
      pokedexRepository.getPokemonSpecie(params);
}
