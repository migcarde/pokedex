import 'dart:io';

import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:data/operations/pokedex/pokedex_local_data_source.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_local_data_source_mocks.dart';

void main() {
  late BoxMock _boxMock;
  late HiveInterfaceMock _hiveInterfaceMock;
  late PokedexLocalDataSource _pokedexLocalDataSource;

  const _box = 'pokedexBox';

  setUp(() {
    final path = Directory.current.path;
    Hive.init(path);
    _boxMock = BoxMock();
    _hiveInterfaceMock = HiveInterfaceMock();
    _pokedexLocalDataSource = PokedexLocalDataSource(hive: _hiveInterfaceMock);
  });

  group('Get pokedex data', (() {
    const List<PokedexDataHiveModel> _expectedResult = [
      PokedexDataHiveModel(
          name: 'example',
          picture: 'picture',
          description: 'description',
          types: ['grass'])
    ];
    const _limit = 1;
    const _offset = 0;

    test('Get pokedex data - Success', (() async {
      // Given
      when(() => _hiveInterfaceMock.openBox(_box))
          .thenAnswer((invocation) async => _boxMock);
      when(() => _boxMock.values)
          .thenAnswer((realInvocation) => _expectedResult);

      // When
      final result =
          await _pokedexLocalDataSource.getPokedexData(_limit, _offset);

      // Then
      expect(result, _expectedResult);
      verify((() => _hiveInterfaceMock.openBox(_box)));
      verify((() => _boxMock.values));
    }));
  }));

  group('Save pokedex data', (() {
    const List<PokedexBusiness> _pokedexToSave = [
      PokedexBusiness(
          name: 'name',
          picture: 'picture',
          description: 'description',
          types: ['types'])
    ];

    final List<PokedexDataHiveModel> _pokedexHiveModelToSave =
        _pokedexToSave.map((e) => e.toHiveModel()).toList();
    test('Save pokedex data - Success', () async {
      // Given
      when(() => _hiveInterfaceMock.openBox(_box))
          .thenAnswer((invocation) async => _boxMock);

      when(() => _boxMock.addAll(_pokedexHiveModelToSave))
          .thenAnswer((invocation) async => const Iterable<int>.empty());

      // Then
      expect(_pokedexLocalDataSource.savePokedexData(_pokedexToSave),
          isInstanceOf<Future<void>>());
    });
  }));
}
