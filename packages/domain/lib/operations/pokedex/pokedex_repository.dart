import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_details_business.dart';

abstract class PokedexRepository {
  Future<BasePaginationBusiness<PokemonBusiness>> getPokemons(
      int offset, int limit);

  Future<PokemonDetailsBusiness> getPokemon(String url);
}
