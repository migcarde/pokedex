import 'package:domain/operations/pokedex/get_pokedex.dart';
import 'package:domain/operations/pokedex/get_pokemon_description.dart';
import 'package:domain/operations/pokedex/get_pokemon_details.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Remote data source
  locator.registerFactory(() => GetPokedex(pokedexRepository: locator()));
  locator
      .registerFactory(() => GetPokemonDetails(pokedexRepository: locator()));
  locator.registerFactory(
      () => GetPokemonDescription(pokedexRepository: locator()));
}
