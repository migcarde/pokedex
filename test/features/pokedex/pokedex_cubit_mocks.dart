import 'package:domain/operations/pokedex/get_pokedex.dart';
import 'package:domain/operations/pokedex/get_pokedex_by_url.dart';
import 'package:domain/operations/pokedex/get_pokedex_from_database.dart';
import 'package:domain/operations/pokedex/get_pokemon_description.dart';
import 'package:domain/operations/pokedex/get_pokemon_details.dart';
import 'package:domain/operations/pokedex/save_pokedex_to_database.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPokedex extends Mock implements GetPokedex {}

class MockGetPokedexByUrl extends Mock implements GetPokedexByUrl {}

class MockGetPokemonDetails extends Mock implements GetPokemonDetails {}

class MockGetPokemonDescription extends Mock implements GetPokemonDescription {}

class MockGetPokedexFromDatabase extends Mock
    implements GetPokedexFromDatabase {}

class MockSavePokedexToDatabase extends Mock implements SavePokedexToDatabase {}
