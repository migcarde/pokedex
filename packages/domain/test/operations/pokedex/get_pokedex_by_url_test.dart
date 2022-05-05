import 'package:data/network/repository_failure.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/get_pokedex_by_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock _pokedexRepositoryMock;
  late GetPokedexByUrl _getPokedexByUrl;

  setUp(() {
    _pokedexRepositoryMock = PokedexRepositoryMock();
    _getPokedexByUrl =
        GetPokedexByUrl(pokedexRepository: _pokedexRepositoryMock);
  });

  group('Get pokedex by url', (() {
    const _url = 'www.example.com';

    const _expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokedex by url - Success', () async {
      // Given
      when(() => _pokedexRepositoryMock.getPokemonsByUrl(_url))
          .thenAnswer((invocation) async => _expectedResult);

      // When
      final result = await _getPokedexByUrl.call(_url);

      // Then
      expect(result, _expectedResult);
      verify(
        () => _pokedexRepositoryMock.getPokemonsByUrl(_url),
      );
      verifyNoMoreInteractions(_pokedexRepositoryMock);
    });

    test('Get pokedex by url - Repository exception', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemonsByUrl(_url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemonsByUrl(_url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex by url - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemonsByUrl(_url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemonsByUrl(_url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex by url - Unknown expection', () async {
      // Given
      when((() => _pokedexRepositoryMock.getPokemonsByUrl(_url)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryMock.getPokemonsByUrl(_url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
