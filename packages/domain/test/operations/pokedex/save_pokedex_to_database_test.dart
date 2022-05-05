import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/operations/pokedex/save_pokedex_to_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock _pokedexRepositoryMock;
  late SavePokedexToDatabase _savePokedexToDatabase;

  setUp((() {
    _pokedexRepositoryMock = PokedexRepositoryMock();
    _savePokedexToDatabase =
        SavePokedexToDatabase(pokedexRepository: _pokedexRepositoryMock);
  }));

  group('Save pokedex to database', (() {
    const _params = [
      PokedexBusiness(
          name: 'name',
          picture: 'picture',
          description: 'description',
          types: ['types'])
    ];

    test('Save pokedex to database - Success', (() async {
      // Given
      when(() => _pokedexRepositoryMock.savePokedexData(_params))
          .thenAnswer((invocation) async => Future<void>);

      // Then
      expect(
          _savePokedexToDatabase.call(_params), isInstanceOf<Future<void>>());
      verify(() => _pokedexRepositoryMock.savePokedexData(_params));
      verifyNoMoreInteractions(_pokedexRepositoryMock);
    }));

    test('Save pokedex to database - Repository exception', (() async {
      // Given
      when(() => _pokedexRepositoryMock.savePokedexData(_params))
          .thenThrow(RepositoryException());

      // Then
      expect(_savePokedexToDatabase.call(_params),
          throwsA(isInstanceOf<RepositoryException>()));
    }));

    test('Save pokedex to database - Unauthorized exception', (() async {
      // Given
      when(() => _pokedexRepositoryMock.savePokedexData(_params))
          .thenThrow(Unauthorized());

      // Then
      expect(_savePokedexToDatabase.call(_params),
          throwsA(isInstanceOf<Unauthorized>()));
    }));

    test('Save pokedex to database - Unknown exception', (() async {
      // Given
      when(() => _pokedexRepositoryMock.savePokedexData(_params))
          .thenThrow(Unknown());

      // Then
      expect(_savePokedexToDatabase.call(_params),
          throwsA(isInstanceOf<Unknown>()));
    }));
  }));
}
