import 'package:domain/operations/pokedex/get_pokemon_details_by_id.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_evolutions_from_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_specie.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPokemonDetailsById extends Mock implements GetPokemonDetailsById {}

class MockGetPokemonDetailsByUrl extends Mock
    implements GetPokemonDetailsByUrl {}

class MockGetPokemonSpecie extends Mock implements GetPokemonSpecie {}

class MockGetPokemonEvolutionsFromUrl extends Mock
    implements GetPokemonEvolutionsFromUrl {}
