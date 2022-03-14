import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:data/models/pokemon_details_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:data/models/pokemon_specie_response.dart';
import 'package:data/operations/pokedex/pokedex_local_data_source.dart';
import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_specie_business.dart';

import 'package:domain/operations/pokedex/pokedex_repository.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource pokedexRemoteDataSource;
  final PokedexLocalDataSource pokedexLocalDataSource;

  PokedexRepositoryImpl({
    required this.pokedexRemoteDataSource,
    required this.pokedexLocalDataSource,
  });

  @override
  Future<BasePaginationBusiness<PokemonBusiness>> getPokemons(
      int offset, int limit) async {
    final pokemons = await pokedexRemoteDataSource.getPokemons(offset, limit);

    return pokemons.toDomain(
      pokemons.results.map((pokemon) => pokemon.toDomain()).toList(),
    );
  }

  @override
  Future<BasePaginationBusiness<PokemonBusiness>> getPokemonsByUrl(
      String url) async {
    final pokemons = await pokedexRemoteDataSource.getPokemonsByUrl(url);

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

  @override
  Future<List<PokedexBusiness>> getPokedexData(int limit, int offset) async {
    final pokedexData =
        await pokedexLocalDataSource.getPokedexData(limit, offset);

    return pokedexData.map((pokemon) => pokemon.toDomain()).toList();
  }
}
