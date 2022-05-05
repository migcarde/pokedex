import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokemon_specie_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_description.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock _pokedexRepositoryMock;
  late GetPokemonDescription _getPokemonDescription;

  setUp((() {
    _pokedexRepositoryMock = PokedexRepositoryMock();
    _getPokemonDescription =
        GetPokemonDescription(pokedexRepository: _pokedexRepositoryMock);
  }));

  group('Get pokemon description', () {
    const _url = 'https://pokeapi.co/api/v2/pokemon-species/1/';
    const _pokemonFlavorEntries = [
      PokemonFlavorEntryBusiness(
          text:
              'A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.',
          language: PokemonLanguageBusiness(name: 'en')),
    ];
    const _expectedResult =
        PokemonSpecieBusiness(flavors: _pokemonFlavorEntries);

    test('Get pokemon description - Success', () async {
      // Given
      when(() => _pokedexRepositoryMock.getPokemonSpecie(_url))
          .thenAnswer((invocation) async => _expectedResult);

      // When
      final result = await _getPokemonDescription.call(_url);

      // Then
      expect(result, _expectedResult);
      verify(
        () => _pokedexRepositoryMock.getPokemonSpecie(_url),
      );
      verifyNoMoreInteractions(_pokedexRepositoryMock);
    });

    test('Get pokemon description - Repository exception', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemonSpecie(_url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemonSpecie(_url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon description - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemonSpecie(_url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemonSpecie(_url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon description - Unknown expection', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemonSpecie(_url)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemonSpecie(_url),
          throwsA(isInstanceOf<Unknown>()));
    });
  });
}
