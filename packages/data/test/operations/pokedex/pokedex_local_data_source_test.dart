import 'dart:io';

import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:data/operations/pokedex/pokedex_local_data_source.dart';

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

  group('Get pokedex data -', (() {
    List<PokedexDataHiveModel> expectedResult = [
      PokedexDataHiveModel(
        id: 1,
        name: 'example',
        frontPicture: 'frontPicture',
        backPicture: 'backPicture',
        description: 'description',
        types: ['grass'],
        stats: [],
        species: 'species',
      ),
    ];
    const limit = 1;
    const offset = 0;

    test('Success', (() async {
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
}
