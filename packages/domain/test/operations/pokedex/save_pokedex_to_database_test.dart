import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:domain/operations/pokedex/save_pokedex_to_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_mock.dart';

void main() {
  late PokedexRepositoryMock pokedexRepositoryMock;
  late SavePokedexToDatabase savePokedexToDatabase;

  setUp((() {
    pokedexRepositoryMock = PokedexRepositoryMock();
    savePokedexToDatabase =
        SavePokedexToDatabase(pokedexRepository: pokedexRepositoryMock);
  }));

  group('Save pokedex to database', (() {
    const params = [
      PokedexBusiness(
        name: 'name',
        picture: 'picture',
        description: 'description',
        types: ['types'],
        stats: [
          PokemonStatsBusiness(type: PokemonStatsTypeBusiness.hp, value: 0),
        ],
        pokemonForm: 'pokemon form',
        evolutionChain: 'evolution chain',
      ),
    ];

    test('Save pokedex to database - Success', (() async {
      // Given
      when(() => pokedexRepositoryMock.savePokedexData(params))
          .thenAnswer((invocation) async => Future<void>);

      // Then
      expect(savePokedexToDatabase.call(params), isInstanceOf<Future<void>>());
      verify(() => pokedexRepositoryMock.savePokedexData(params));
      verifyNoMoreInteractions(pokedexRepositoryMock);
    }));

    test('Save pokedex to database - Repository exception', (() async {
      // Given
      when(() => pokedexRepositoryMock.savePokedexData(params))
          .thenThrow(RepositoryException());

      // Then
      expect(savePokedexToDatabase.call(params),
          throwsA(isInstanceOf<RepositoryException>()));
    }));

    test('Save pokedex to database - Unauthorized exception', (() async {
      // Given
      when(() => pokedexRepositoryMock.savePokedexData(params))
          .thenThrow(Unauthorized());

      // Then
      expect(savePokedexToDatabase.call(params),
          throwsA(isInstanceOf<Unauthorized>()));
    }));

    test('Save pokedex to database - Unknown exception', (() async {
      // Given
      when(() => pokedexRepositoryMock.savePokedexData(params))
          .thenThrow(Unknown());

      // Then
      expect(
          savePokedexToDatabase.call(params), throwsA(isInstanceOf<Unknown>()));
    }));
  }));
}
