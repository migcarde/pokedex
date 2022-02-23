import 'package:data/models/pokemon_reponse.dart';
import 'package:data/operations/pokedex/pokedex_service.dart';

class PokedexRemoteDataSource {
  final PokemonService service;

  const PokedexRemoteDataSource({required this.service});

  Future<List<PokemonResponse>> getPokemons(int offset, int limit) async {
    final response = await service.getPokemons(offset, limit);

    return response.map((json) => PokemonResponse.fromJson(json)).toList();
  }
}
