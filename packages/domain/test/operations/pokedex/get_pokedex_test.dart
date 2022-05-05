import 'package:data/network/repository_failure.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pagination_params_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/get_pokedex.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock _pokedexRepository;
  late GetPokedex _getPokedex;

  setUp((() {
    _pokedexRepository = PokedexRepositoryMock();
    _getPokedex = GetPokedex(pokedexRepository: _pokedexRepository);
  }));

  group('Get pokedex call', () {
    const _params = PaginationParamsBusiness(offset: 0, limit: 1);

    const _expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokedex - Success', () async {
      // Given
      when(() => _pokedexRepository.getPokemons(_params.offset, _params.limit))
          .thenAnswer((invocation) async => _expectedResult);

      // When
      final result = await _getPokedex.call(_params);

      // Then
      expect(result, _expectedResult);
      verify(
        () => _pokedexRepository.getPokemons(_params.offset, _params.limit),
      );
      verifyNoMoreInteractions(_pokedexRepository);
    });

    test('Get pokedex - Repository exception', () async {
      // Given
      when((() =>
              _pokedexRepository.getPokemons(_params.offset, _params.limit)))
          .thenThrow(RepositoryException());

      // Then
      expect(
          () => _pokedexRepository.getPokemons(_params.offset, _params.limit),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex - Unauthorized exception', () async {
      // Given
      when((() =>
              _pokedexRepository.getPokemons(_params.offset, _params.limit)))
          .thenThrow(Unauthorized());

      // Then
      expect(
          () => _pokedexRepository.getPokemons(_params.offset, _params.limit),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex - Unknown expection', () async {
      // Given
      when((() =>
              _pokedexRepository.getPokemons(_params.offset, _params.limit)))
          .thenThrow(Unknown());

      // Then
      expect(
          () => _pokedexRepository.getPokemons(_params.offset, _params.limit),
          throwsA(isInstanceOf<Unknown>()));
    });
  });
}
