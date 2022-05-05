import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock _pokedexRepositoryMock;
  late GetPokemonDetails _getPokemonDetails;

  setUp(() {
    _pokedexRepositoryMock = PokedexRepositoryMock();
    _getPokemonDetails =
        GetPokemonDetails(pokedexRepository: _pokedexRepositoryMock);
  });

  group('Get pokemon details', (() {
    const _url = 'https://pokeapi.co/api/v2/pokemon/1/';

    const _pokemonExpectedSprite = PokemonSpriteBusiness(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    const _pokemonSlots = [
      PokemonSlotTypeBusiness(type: PokemonTypeBusiness(name: 'grass')),
      PokemonSlotTypeBusiness(type: PokemonTypeBusiness(name: 'poison')),
    ];
    const _pokemonSpecie = PokemonDetailsSpecieBusiness(
        url: 'https://pokeapi.co/api/v2/pokemon-species/1/');
    const _expectedResult = PokemonDetailsBusiness(
      sprite: _pokemonExpectedSprite,
      slots: _pokemonSlots,
      specie: _pokemonSpecie,
    );

    test('Get pokemon details - Success', () async {
      // Given
      when(() => _pokedexRepositoryMock.getPokemon(_url))
          .thenAnswer((invocation) async => _expectedResult);

      // When
      final result = await _getPokemonDetails.call(_url);

      // Then
      expect(result, _expectedResult);
      verify(
        () => _pokedexRepositoryMock.getPokemon(_url),
      );
      verifyNoMoreInteractions(_pokedexRepositoryMock);
    });

    test('Get pokemon details - Repository exception', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemon(_url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemon(_url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon details - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemon(_url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemon(_url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon details - Unknown expection', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemon(_url)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemon(_url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
