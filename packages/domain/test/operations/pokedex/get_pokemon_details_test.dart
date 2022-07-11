import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepositoryMock;
  late GetPokemonDetails getPokemonDetails;

  setUp(() {
    pokedexRepositoryMock = PokedexRepositoryMock();
    getPokemonDetails =
        GetPokemonDetails(pokedexRepository: pokedexRepositoryMock);
  });

  group('Get pokemon details', (() {
    const url = 'https://pokeapi.co/api/v2/pokemon/1/';

    const pokemonExpectedSprite = PokemonSpriteBusiness(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    const pokemonSlots = [
      PokemonSlotTypeBusiness(type: PokemonTypeBusiness(name: 'grass')),
      PokemonSlotTypeBusiness(type: PokemonTypeBusiness(name: 'poison')),
    ];

    const pokemonStats = [
      PokemonStatsBusiness(type: PokemonStatsTypeBusiness.hp, value: 0),
      PokemonStatsBusiness(type: PokemonStatsTypeBusiness.attack, value: 1),
    ];
    const pokemonSpecie = PokemonDetailsSpecieBusiness(
        url: 'https://pokeapi.co/api/v2/pokemon-species/1/');
    const expectedResult = PokemonDetailsBusiness(
      sprite: pokemonExpectedSprite,
      slots: pokemonSlots,
      specie: pokemonSpecie,
      stats: pokemonStats,
    );

    test('Get pokemon details - Success', () async {
      // Given
      when(() => pokedexRepositoryMock.getPokemon(url))
          .thenAnswer((invocation) async => expectedResult);

      // When
      final result = await getPokemonDetails.call(url);

      // Then
      expect(result, expectedResult);
      verify(
        () => pokedexRepositoryMock.getPokemon(url),
      );
      verifyNoMoreInteractions(pokedexRepositoryMock);
    });

    test('Get pokemon details - Repository exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemon(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryMock.getPokemon(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon details - Unauthorized exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemon(url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryMock.getPokemon(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon details - Unknown expection', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemon(url))).thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryMock.getPokemon(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
