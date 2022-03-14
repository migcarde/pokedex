import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_specie_business.dart';

abstract class PokedexRepository {
  Future<BasePaginationBusiness<PokemonBusiness>> getPokemons(
      int offset, int limit);
  Future<BasePaginationBusiness<PokemonBusiness>> getPokemonsByUrl(String url);
  Future<PokemonDetailsBusiness> getPokemon(String url);
  Future<PokemonSpecieBusiness> getPokemonSpecie(String url);
  Future<List<PokedexBusiness>> getPokedexData(int limit, int offset);
}
