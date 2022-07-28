import 'dart:io';

import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:data/operations/pokedex/pokedex_local_data_source.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_local_data_source_mocks.dart';

void main() {
  late BoxMock boxMock;
  late HiveInterfaceMock hiveInterfaceMock;
  late PokedexLocalDataSource pokedexLocalDataSource;

  const box = 'pokedexBox';

  setUp(() {
    final path = Directory.current.path;
    Hive.init(path);
    boxMock = BoxMock();
    hiveInterfaceMock = HiveInterfaceMock();
    pokedexLocalDataSource = PokedexLocalDataSource(hive: hiveInterfaceMock);
  });

  group('Get pokedex data', (() {
    List<PokedexDataHiveModel> expectedResult = [
      PokedexDataHiveModel(
          name: 'example',
          picture: 'picture',
          description: 'description',
          types: ['grass'],
          stats: [],
          evolutionChain: 'evolution chain',
          pokemonForm: 'pokemon form'),
    ];
    const limit = 1;
    const offset = 0;

    test('Get pokedex data - Success', (() async {
      // Given
      when(() => hiveInterfaceMock.openBox(box))
          .thenAnswer((invocation) async => boxMock);
      when(() => boxMock.values).thenAnswer((realInvocation) => expectedResult);

      // When
      final result = await pokedexLocalDataSource.getPokedexData(limit, offset);

      // Then
      expect(result, expectedResult);
      verify((() => hiveInterfaceMock.openBox(box)));
      verify((() => boxMock.values));
    }));
  }));

  group('Save pokedex data', (() {
    const List<PokedexBusiness> pokedexToSave = [
      PokedexBusiness(
        name: 'name',
        picture: 'picture',
        description: 'description',
        types: ['types'],
        stats: [],
        evolutionChain: 'evolution chain',
        pokemonForm: 'pokemon form',
      )
    ];

    final List<PokedexDataHiveModel> pokedexHiveModelToSave =
        pokedexToSave.map((e) => e.toHiveModel()).toList();
    test('Save pokedex data - Success', () async {
      // Given
      when(() => hiveInterfaceMock.openBox(box))
          .thenAnswer((invocation) async => boxMock);

      when(() => boxMock.addAll(pokedexHiveModelToSave))
          .thenAnswer((invocation) async => const Iterable<int>.empty());

      // Then
      expect(pokedexLocalDataSource.savePokedexData(pokedexToSave),
          isInstanceOf<Future<void>>());
    });
  }));
}
