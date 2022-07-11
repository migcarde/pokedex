import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokedex_local_database_params.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:domain/operations/pokedex/get_pokedex_from_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepositoryMock;
  late GetPokedexFromDatabase getPokedexFromDatabase;

  setUp(() {
    pokedexRepositoryMock = PokedexRepositoryMock();
    getPokedexFromDatabase =
        GetPokedexFromDatabase(pokedexRepository: pokedexRepositoryMock);
  });

  group('Get pokedex from database', (() {
    const params = PokedexLocalDatabaseParams(limit: 1, offset: 0);

    const List<PokedexBusiness> expectedResult = [
      PokedexBusiness(
        name: 'name',
        picture: 'picture',
        description: 'description',
        types: ['types'],
        stats: [
          PokemonStatsBusiness(
            type: PokemonStatsTypeBusiness.hp,
            value: 0,
          ),
        ],
      ),
    ];

    test('Get pokedex from database - Success', (() async {
      // Given
      when(() =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset))
          .thenAnswer((invocation) async => expectedResult);

      // When
      final result = await getPokedexFromDatabase(params);

      // Then
      expect(result, expectedResult);
      verify(() =>
          pokedexRepositoryMock.getPokedexData(params.limit, params.offset));
      verifyNoMoreInteractions(pokedexRepositoryMock);
    }));

    test('Get pokedex from database - Repository exception', (() async {
      // Given
      when(() =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset))
          .thenThrow(RepositoryException());

      // Then
      expect(
          () =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset),
          throwsA(isInstanceOf<RepositoryException>()));
    }));

    test('Get pokedex from database - Unauthorized exception', (() async {
      // Given
      when(() =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset))
          .thenThrow(Unauthorized());

      // Then
      expect(
          () =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset),
          throwsA(isInstanceOf<Unauthorized>()));
    }));

    test('Get pokedex from database - Unknown exception', (() async {
      // Given
      when(() =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset))
          .thenThrow(Unknown());

      // Then
      expect(
          () =>
              pokedexRepositoryMock.getPokedexData(params.limit, params.offset),
          throwsA(isInstanceOf<Unknown>()));
    }));
  }));
}
