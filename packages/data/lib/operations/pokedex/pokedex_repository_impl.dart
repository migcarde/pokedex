import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:domain/models/pokemon_business.dart';

import 'package:domain/operations/pokedex/pokedex_repository.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource pokedexRemoteDataSource;

  PokedexRepositoryImpl({required this.pokedexRemoteDataSource});

  @override
  Future<List<PokemonBusiness>> getPokemons(int offset, int limit) async {
    final pokemons = await pokedexRemoteDataSource.getPokemons(offset, limit);

    return pokemons.map((e) => e.t)
  }
}
