import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokedex_local_database_params.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:domain/operations/pokedex/get_pokedex_from_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock _pokedexRepositoryMock;
  late GetPokedexFromDatabase _getPokedexFromDatabase;

  setUp(() {
    _pokedexRepositoryMock = PokedexRepositoryMock();
    _getPokedexFromDatabase =
        GetPokedexFromDatabase(pokedexRepository: _pokedexRepositoryMock);
  });

  group('Get pokedex from database', (() {
    const _params = PokedexLocalDatabaseParams(limit: 1, offset: 0);

    const List<PokedexBusiness> _expectedResult = [
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
      when(() => _pokedexRepositoryMock.getPokedexData(
              _params.limit, _params.offset))
          .thenAnswer((invocation) async => _expectedResult);

      // When
      final result = await _getPokedexFromDatabase(_params);

      // Then
      expect(result, _expectedResult);
      verify(() =>
          _pokedexRepositoryMock.getPokedexData(_params.limit, _params.offset));
      verifyNoMoreInteractions(_pokedexRepositoryMock);
    }));

    test('Get pokedex from database - Repository exception', (() async {
      // Given
      when(() => _pokedexRepositoryMock.getPokedexData(
          _params.limit, _params.offset)).thenThrow(RepositoryException());

      // Then
      expect(
          () => _pokedexRepositoryMock.getPokedexData(
              _params.limit, _params.offset),
          throwsA(isInstanceOf<RepositoryException>()));
    }));

    test('Get pokedex from database - Unauthorized exception', (() async {
      // Given
      when(() => _pokedexRepositoryMock.getPokedexData(
          _params.limit, _params.offset)).thenThrow(Unauthorized());

      // Then
      expect(
          () => _pokedexRepositoryMock.getPokedexData(
              _params.limit, _params.offset),
          throwsA(isInstanceOf<Unauthorized>()));
    }));

    test('Get pokedex from database - Unknown exception', (() async {
      // Given
      when(() => _pokedexRepositoryMock.getPokedexData(
          _params.limit, _params.offset)).thenThrow(Unknown());

      // Then
      expect(
          () => _pokedexRepositoryMock.getPokedexData(
              _params.limit, _params.offset),
          throwsA(isInstanceOf<Unknown>()));
    }));
  }));
}
