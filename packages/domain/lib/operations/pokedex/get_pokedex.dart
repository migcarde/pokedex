import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pagination_params_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokedex extends BaseUseCase<BasePaginationBusiness<PokemonBusiness>,
    PaginationParamsBusiness> {
  final PokedexRepository pokedexRepository;

  GetPokedex({required this.pokedexRepository});

  @override
  Future<BasePaginationBusiness<PokemonBusiness>> call(
          PaginationParamsBusiness params) =>
      pokedexRepository.getPokemons(params.offset, params.limit);
}
