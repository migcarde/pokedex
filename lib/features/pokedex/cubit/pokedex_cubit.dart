import 'package:bloc/bloc.dart';
import 'package:domain/models/pagination_params_business.dart';
import 'package:domain/models/pokedex_local_database_params.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/get_pokedex.dart';
import 'package:domain/operations/pokedex/get_pokedex_by_url.dart';
import 'package:domain/operations/pokedex/get_pokedex_from_database.dart';
import 'package:domain/operations/pokedex/get_pokemon_description.dart';
import 'package:domain/operations/pokedex/get_pokemon_details.dart';
import 'package:domain/operations/pokedex/save_pokedex_to_database.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/base/base_pagination_view_model.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';

part 'pokedex_state.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final GetPokedex getPokedex;
  final GetPokedexByUrl getPokedexByUrl;
  final GetPokemonDetails getPokemonDetails;
  final GetPokemonDescription getPokemonDescription;
  final GetPokedexFromDatabase getPokedexFromDatabase;
  final SavePokedexToDatabase savePokedexToDatabase;

  PokedexCubit({
    required this.getPokedex,
    required this.getPokedexByUrl,
    required this.getPokemonDetails,
    required this.getPokemonDescription,
    required this.getPokedexFromDatabase,
    required this.savePokedexToDatabase,
  }) : super(PokedexInitial());

  static const int _defaultOffset = 0;
  static const int _defaultLimit = 30;

  void getPokemons(
      {int offset = _defaultOffset, int limit = _defaultLimit}) async {
    try {
      final pokedexLocalInformation =
          await _getPokedexDataFromDatabase(limit, offset);
      if (pokedexLocalInformation.results.isNotEmpty) {
        emit(PokedexData(data: pokedexLocalInformation));
      } else {
        _getPokemonFromRemote(offset: offset, limit: limit);
      }
    } catch (e) {
      emit(const PokedexError(
          message: 'Opps, something is wrong. Please, try again later'));
    }
  }

  void _getPokemonFromRemote({required int offset, required int limit}) async {
    final params = PaginationParamsBusiness(offset: offset, limit: limit);
    final response = await getPokedex(params);

    final pokedex = await _getPokemonDetails(response.results);
    final pokedexData =
        PokedexData(data: response.toViewModel<PokedexViewModel>(pokedex));
    _savePokemonToDatabase(pokedexData.data.results);

    emit(pokedexData);
  }

  void getMorePokemons(BasePaginationViewModel<PokedexViewModel> pokemons,
      {int offset = _defaultOffset, int limit = _defaultLimit}) async {
    try {
      final pokedexLocalInformation =
          await _getPokedexDataFromDatabase(limit, offset);

      if (pokedexLocalInformation.results.isNotEmpty) {
        pokedexLocalInformation.results.insertAll(0, pokemons.results);
        emit(PokedexData(data: pokedexLocalInformation));
      } else {
        final params = PaginationParamsBusiness(offset: offset, limit: limit);
        final response = await getPokedex(params);

        final pokedex = await _getPokemonDetails(response.results);
        pokemons.results.addAll(pokedex);
        final pokedexData = PokedexData(
            data: response.toViewModel<PokedexViewModel>(pokemons.results));
        _savePokemonToDatabase(pokedex);

        emit(pokedexData);
      }
    } catch (e) {
      emit(const PokedexError(
          message: 'Opps, something is wrong. Please, try again later'));
    }
  }

  void getPokemonsByUrl(
      String url, BasePaginationViewModel<PokedexViewModel> pokemons) async {
    try {
      final response = await getPokedexByUrl(url);

      final pokedex = await _getPokemonDetails(response.results);
      pokemons.results.addAll(pokedex);
      final pokedexData = PokedexData(
          data: response.toViewModel<PokedexViewModel>(pokemons.results));
      _savePokemonToDatabase(pokedex);

      emit(pokedexData);
    } catch (e) {
      emit(const PokedexError(
          message: 'Opps, something is wrong. Please, try again later'));
    }
  }

  Future<List<PokedexViewModel>> _getPokemonDetails(
      List<PokemonBusiness> pokemons) async {
    List<PokedexViewModel> result = [];
    for (var i = 0; i < pokemons.length; i++) {
      final pokemon = pokemons[i];
      final pokemonDetails = await getPokemonDetails(pokemon.url);
      final pokemonDescription =
          await getPokemonDescription(pokemonDetails.specie.url);

      result.add(PokedexViewModel(
        name: pokemon.name,
        picture: pokemonDetails.sprite.frontDefault,
        types: pokemonDetails.slots
            .map((pokemonDetail) => pokemonDetail.type.name.getType())
            .toList(),
        description: pokemonDescription.flavors
            .firstWhere((flavor) => flavor.language.name == 'en')
            .text
            .removeJumpLines(),
        stats: pokemonDetails.stats.map((stat) => stat.toViewModel()).toList(),
        evolutionChain: pokemonDescription.evolutionChain,
        pokemonForm: pokemonDetails.pokemonForm.first.url,
      ));
    }

    return result;
  }

  Future<BasePaginationViewModel<PokedexViewModel>> _getPokedexDataFromDatabase(
      int limit, int offset) async {
    final pokedexData = await getPokedexFromDatabase
        .call(PokedexLocalDatabaseParams(limit: limit, offset: offset));
    final pokemons =
        pokedexData.map((pokemon) => pokemon.toViewModel()).toList();

    return BasePaginationViewModel<PokedexViewModel>(
      count: offset + pokemons.length,
      results: pokemons,
    );
  }

  Future<void> _savePokemonToDatabase(List<PokedexViewModel> pokemons) async {
    await savePokedexToDatabase(
      pokemons.map((pokemon) => pokemon.toBusiness()).toList(),
    );
  }
}
