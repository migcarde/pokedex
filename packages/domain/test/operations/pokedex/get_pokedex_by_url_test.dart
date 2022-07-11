import 'package:data/network/repository_failure.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/get_pokedex_by_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepositoryMock;
  late GetPokedexByUrl getPokedexByUrl;

  setUp(() {
    pokedexRepositoryMock = PokedexRepositoryMock();
    getPokedexByUrl = GetPokedexByUrl(pokedexRepository: pokedexRepositoryMock);
  });

  group('Get pokedex by url', (() {
    const url = 'www.example.com';

    const expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokedex by url - Success', () async {
      // Given
      when(() => pokedexRepositoryMock.getPokemonsByUrl(url))
          .thenAnswer((invocation) async => expectedResult);

      // When
      final result = await getPokedexByUrl.call(url);

      // Then
      expect(result, expectedResult);
      verify(
        () => pokedexRepositoryMock.getPokemonsByUrl(url),
      );
      verifyNoMoreInteractions(pokedexRepositoryMock);
    });

    test('Get pokedex by url - Repository exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonsByUrl(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonsByUrl(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex by url - Unauthorized exception', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonsByUrl(url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonsByUrl(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex by url - Unknown expection', () async {
      // Given
      when((() => pokedexRepositoryMock.getPokemonsByUrl(url)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryMock.getPokemonsByUrl(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
