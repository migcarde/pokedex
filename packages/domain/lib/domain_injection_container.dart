import 'package:domain/operations/pokedex/get_pokedex.dart';
import 'package:domain/operations/pokedex/get_pokedex_by_url.dart';
import 'package:domain/operations/pokedex/get_pokedex_from_database.dart';
import 'package:domain/operations/pokedex/get_pokemon_description.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_id.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_evolution_from_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_evolutions.dart';
import 'package:domain/operations/pokedex/save_pokedex_to_database.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Remote data source
  locator.registerFactory(() => GetPokedex(pokedexRepository: locator()));
  locator.registerFactory(() => GetPokedexByUrl(pokedexRepository: locator()));
  locator.registerFactory(
      () => GetPokemonDetailsById(pokedexRepository: locator()));
  locator.registerFactory(
      () => GetPokemonDetailsByUrl(pokedexRepository: locator()));
  locator.registerFactory(
      () => GetPokemonDescription(pokedexRepository: locator()));
  locator.registerFactory(
      () => GetPokemonEvolutions(pokedexRepository: locator()));
  locator.registerFactory(
      () => GetPokemonEvolutionFromUrl(pokedexRepository: locator()));

  // Local data source
  locator.registerFactory(
      () => GetPokedexFromDatabase(pokedexRepository: locator()));
  locator.registerFactory(
      () => SavePokedexToDatabase(pokedexRepository: locator()));
}
