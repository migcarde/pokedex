import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokemon_specie_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_description.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepositoryMock;
  late GetPokemonDescription getPokemonDescription;

  setUp((() {
    pokedexRepositoryMock = PokedexRepositoryMock();
    getPokemonDescription =
        GetPokemonDescription(pokedexRepository: pokedexRepositoryMock);
  }));

  group('Get pokemon description', () {
    const url = 'https://pokeapi.co/api/v2/pokemon-species/1/';
    const pokemonFlavorEntries = [
      PokemonFlavorEntryBusiness(
          text:
              'A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.',
          language: PokemonLanguageBusiness(name: 'en')),
    ];
    const expectedResult = PokemonSpecieBusiness(
      flavors: pokemonFlavorEntries,
      evolutionChain: 'evolution chain',
    );

    test('Get pokemon description - Success', () async {
      // Given
      when(() => pokedexRepositoryMock.getPokemonSpecie(url))
          .thenAnswer((invocation) async => expectedResult);

      // When
      final result = await getPokemonDescription.call(url);

      // Then
      expect(result, expectedResult);
      verify(
        () => pokedexRepositoryMock.getPokemonSpecie(url),
      );
      verifyNoMoreInteractions(pokedexRepositoryMock);
    });

    test('Get pokemon description - Repository exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonSpecie(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonSpecie(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon description - Unauthorized exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonSpecie(url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonSpecie(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon description - Unknown expection', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonSpecie(url)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonSpecie(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  });
}
