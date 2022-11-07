import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_evolutions_from_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepositoryMock;
  late GetPokemonEvolutionsFromUrl getPokemonEvolutionsFromUrl;

  setUp(() {
    pokedexRepositoryMock = PokedexRepositoryMock();
    getPokemonEvolutionsFromUrl =
        GetPokemonEvolutionsFromUrl(pokedexRepository: pokedexRepositoryMock);
  });

  group('Get pokemon evolutions from url -', () {
    const params = 'http://www.example.com';

    const species = PokemonBusiness(
      name: 'name',
      url: 'url',
    );
    const List<PokemonEvolutionBusiness> evolutionDetails = [];
    const expectedResult = PokemonEvolutionBusiness(
      species: species,
      evolutionDetails: evolutionDetails,
    );

    test('Success', () async {
      // Given

      when(() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params))
          .thenAnswer((invocation) async => expectedResult);

      // When
      final result = await getPokemonEvolutionsFromUrl(params);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params));
      verifyNoMoreInteractions(pokedexRepositoryMock);
    });

    test('Repository exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Unauthorized exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Unknown expection', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonEvolutionsFromUrl(params),
          throwsA(isInstanceOf<Unknown>()));
    });
  });
}
