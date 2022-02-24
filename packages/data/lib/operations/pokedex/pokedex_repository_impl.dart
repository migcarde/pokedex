import 'package:data/models/pokemon_details_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:data/models/pokemon_specie_response.dart';
import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_specie_busines.dart';

import 'package:domain/operations/pokedex/pokedex_repository.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource pokedexRemoteDataSource;

  PokedexRepositoryImpl({required this.pokedexRemoteDataSource});

  @override
  Future<BasePaginationBusiness<PokemonBusiness>> getPokemons(
      int offset, int limit) async {
    final pokemons = await pokedexRemoteDataSource.getPokemons(offset, limit);

    return pokemons.toDomain(
      pokemons.results.map((pokemon) => pokemon.toDomain()).toList(),
    );
  }

  @override
  Future<PokemonDetailsBusiness> getPokemon(String url) async {
    final pokemon = await pokedexRemoteDataSource.getPokemon(url);

    return pokemon.toDomain();
  }

  @override
  Future<PokemonSpecieBusiness> getPokemonSpecie(String url) async {
    final specie = await pokedexRemoteDataSource.getPokemonSpecie(url);

    return specie.toDomain();
  }
}
