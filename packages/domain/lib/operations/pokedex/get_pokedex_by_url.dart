import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokedexByUrl
    extends BaseUseCase<BasePaginationBusiness<PokemonBusiness>, String> {
  final PokedexRepository pokedexRepository;

  GetPokedexByUrl({required this.pokedexRepository});

  @override
  Future<BasePaginationBusiness<PokemonBusiness>> call(String params) =>
      pokedexRepository.getPokemonsByUrl(params);
}
