import 'package:data/models/base_pagination_response.dart';
import 'package:data/models/pokemon_details_response.dart';
import 'package:data/models/pokemon_evolution_chain_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:data/models/pokemon_specie_response.dart';
import 'package:data/operations/pokedex/pokedex_service.dart';

class PokedexRemoteDataSource {
  final PokemonService service;

  const PokedexRemoteDataSource({required this.service});

  Future<BasePaginationResponse<PokemonResponse>> getPokemons(
      int offset, int limit) async {
    final response = await service.getPokemons(offset, limit);
    final List<dynamic> list = response['results'];
    final results = list.map((json) => PokemonResponse.fromJson(json)).toList();

    return BasePaginationResponse<PokemonResponse>.fromJson(response, results);
  }

  Future<BasePaginationResponse<PokemonResponse>> getPokemonsByUrl(
      String url) async {
    final response = await service.getPokemonsByUrl(url);
    final List<dynamic> list = response['results'];
    final results = list.map((json) => PokemonResponse.fromJson(json)).toList();

    return BasePaginationResponse<PokemonResponse>.fromJson(response, results);
  }

  Future<PokemonDetailsResponse> getPokemonById(int id) async {
    final response = await service.getPokemonById(id);

    return PokemonDetailsResponse.fromJson(response);
  }

  Future<PokemonDetailsResponse> getPokemonByUrl(String url) async {
    final response = await service.getPokemonByUrl(url);

    return PokemonDetailsResponse.fromJson(response);
  }

  Future<PokemonSpecieResponse> getPokemonSpecie(String url) async {
    final response = await service.getPokemonSpecie(url);

    return PokemonSpecieResponse.fromJson(response);
  }

  Future<PokemonEvolutionChainResponse> getPokemonEvolutions(int id) async {
    final response = await service.getPokemonEvolutions(id);

    return PokemonEvolutionChainResponse.fromJson(response);
  }

  Future<PokemonEvolutionChainResponse> getPokemonEvolutionsFromUrl(
      String url) async {
    final response = await service.getPokemonEvolutionsFromUrl(url);

    return PokemonEvolutionChainResponse.fromJson(response);
  }
}
