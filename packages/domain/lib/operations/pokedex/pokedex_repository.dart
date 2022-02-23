import 'package:domain/models/pokemon_business.dart';

abstract class PokedexRepository {
  Future<List<PokemonBusiness>> getPokemons(int offset, int limit);
}
