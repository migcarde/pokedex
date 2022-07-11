import 'package:data/network/repository_failure.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pagination_params_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/operations/pokedex/get_pokedex.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepository;
  late GetPokedex getPokedex;

  setUp((() {
    pokedexRepository = PokedexRepositoryMock();
    getPokedex = GetPokedex(pokedexRepository: pokedexRepository);
  }));

  group('Get pokedex call', () {
    const params = PaginationParamsBusiness(offset: 0, limit: 1);

    const expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokedex - Success', () async {
      // Given
      when(() => pokedexRepository.getPokemons(params.offset, params.limit))
          .thenAnswer((invocation) async => expectedResult);

      // When
      final result = await getPokedex.call(params);

      // Then
      expect(result, expectedResult);
      verify(
        () => pokedexRepository.getPokemons(params.offset, params.limit),
      );
      verifyNoMoreInteractions(pokedexRepository);
    });

    test('Get pokedex - Repository exception', () async {
      // Given
      when((() => pokedexRepository.getPokemons(params.offset, params.limit)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepository.getPokemons(params.offset, params.limit),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex - Unauthorized exception', () async {
      // Given
      when((() => pokedexRepository.getPokemons(params.offset, params.limit)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepository.getPokemons(params.offset, params.limit),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex - Unknown expection', () async {
      // Given
      when((() => pokedexRepository.getPokemons(params.offset, params.limit)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepository.getPokemons(params.offset, params.limit),
          throwsA(isInstanceOf<Unknown>()));
    });
  });
}
