import 'package:data/models/base_pagination_response.dart';
import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:data/models/pokemon_details_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:data/models/pokemon_specie_response.dart';
import 'package:data/network/repository_failure.dart';
import 'package:data/operations/pokedex/pokedex_repository_impl.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_impl_mocks.dart';

void main() {
  late PokedexRemoteDataSourceMock _pokedexRemoteDataSourceMock;
  late PokedexLocalDataSourceMock _pokedexLocalDataSourceMock;
  late PokedexRepositoryImpl _pokedexRepositoryImpl;

  setUp(() {
    _pokedexRemoteDataSourceMock = PokedexRemoteDataSourceMock();
    _pokedexLocalDataSourceMock = PokedexLocalDataSourceMock();
    _pokedexRepositoryImpl = PokedexRepositoryImpl(
      pokedexRemoteDataSource: _pokedexRemoteDataSourceMock,
      pokedexLocalDataSource: _pokedexLocalDataSourceMock,
    );
  });

  group('Get pokemons', (() {
    const _offset = 0;
    const _limit = 1;

    const BasePaginationResponse<PokemonResponse> _expectedResponse =
        BasePaginationResponse<PokemonResponse>(count: 0, results: []);

    const BasePaginationBusiness<PokemonBusiness> _expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokemons - Success', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemons(_offset, _limit)))
          .thenAnswer((invocation) async => _expectedResponse);

      // When
      final result = await _pokedexRepositoryImpl.getPokemons(_offset, _limit);

      // Then
      expect(result, _expectedResult);
      verify(() => _pokedexRemoteDataSourceMock.getPokemons(_offset, _limit));
      verifyNoMoreInteractions(_pokedexRemoteDataSourceMock);
    });

    test('Get pokemons - Repository exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemons(_offset, _limit)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemons(_offset, _limit),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemons(_offset, _limit)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemons(_offset, _limit),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex - Unknown expection', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemons(_offset, _limit)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemons(_offset, _limit),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
  group('Get pokedex by url', (() {
    const _url = 'www.example.com';

    const BasePaginationResponse<PokemonResponse> _expectedResponse =
        BasePaginationResponse<PokemonResponse>(count: 0, results: []);

    const BasePaginationBusiness<PokemonBusiness> _expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokedex by url - Success', (() async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonsByUrl(_url)))
          .thenAnswer((invocation) async => _expectedResponse);

      // When
      final result = await _pokedexRepositoryImpl.getPokemonsByUrl(_url);

      // Then
      expect(result, _expectedResult);
      verify(() => _pokedexRemoteDataSourceMock.getPokemonsByUrl(_url));
      verifyNoMoreInteractions(_pokedexRemoteDataSourceMock);
    }));

    test('Get pokemons by url - Repository exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonsByUrl(_url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemonsByUrl(_url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex by url - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonsByUrl(_url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemonsByUrl(_url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex by url - Unknown expection', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonsByUrl(_url)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemonsByUrl(_url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon', (() {
    const _url = 'https://pokeapi.co/api/v2/pokemon/1/';

    const _pokemonExpectedSprite = PokemonSpriteResponse(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    const _pokemonSlots = [
      PokemonSlotTypeResponse(type: PokemonTypeResponse(name: 'grass')),
      PokemonSlotTypeResponse(type: PokemonTypeResponse(name: 'poison')),
    ];
    const _pokemonSpecie = PokemonDetailsSpecieResponse(
        url: 'https://pokeapi.co/api/v2/pokemon-species/1/');
    const _expectedResponse = PokemonDetailsResponse(
      sprite: _pokemonExpectedSprite,
      slots: _pokemonSlots,
      specie: _pokemonSpecie,
    );

    final _expectedResult = _expectedResponse.toDomain();

    test('Get pokemon - Success', (() async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemon(_url)))
          .thenAnswer((invocation) async => _expectedResponse);

      // When
      final result = await _pokedexRepositoryImpl.getPokemon(_url);

      // Then
      expect(result, _expectedResult);
      verify(() => _pokedexRemoteDataSourceMock.getPokemon(_url));
      verifyNoMoreInteractions(_pokedexRemoteDataSourceMock);
    }));

    test('Get pokemon - Repository exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemon(_url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemon(_url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemon(_url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemon(_url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon - Unknown expection', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemon(_url)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemon(_url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon specie', (() {
    const _url = 'https://pokeapi.co/api/v2/pokemon-species/1/';
    const _pokemonFlavorEntries = [
      PokemonFlavorEntryResponse(
          text:
              'A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.',
          language: PokemonLanguageResponse(name: 'en')),
    ];
    const _expectedResponse =
        PokemonSpecieResponse(flavors: _pokemonFlavorEntries);
    final _expectedResult = _expectedResponse.toDomain();

    test('Get pokemon specie - Success', (() async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonSpecie(_url)))
          .thenAnswer((invocation) async => _expectedResponse);

      // When
      final result = await _pokedexRepositoryImpl.getPokemonSpecie(_url);

      // Then
      expect(result, _expectedResult);
      verify(() => _pokedexRemoteDataSourceMock.getPokemonSpecie(_url));
      verifyNoMoreInteractions(_pokedexRemoteDataSourceMock);
    }));

    test('Get pokemon specie - Repository exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonSpecie(_url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemonSpecie(_url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon specie - Unauthorized exception', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonSpecie(_url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemonSpecie(_url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon specie - Unknown expection', () async {
      // Given
      when((() => _pokedexRemoteDataSourceMock.getPokemonSpecie(_url)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokemonSpecie(_url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokedex data', (() {
    const List<PokedexDataHiveModel> _expectedResponse = [
      PokedexDataHiveModel(
          name: 'example',
          picture: 'picture',
          description: 'description',
          types: ['grass'])
    ];
    const _limit = 1;
    const _offset = 0;
    final _expectedResult =
        _expectedResponse.map((pokemon) => pokemon.toDomain()).toList();

    test('Get pokedex data - Success', (() async {
      // Given
      when((() => _pokedexLocalDataSourceMock.getPokedexData(_limit, _offset)))
          .thenAnswer((invocation) async => _expectedResponse);

      // When
      final result =
          await _pokedexRepositoryImpl.getPokedexData(_limit, _offset);

      // Then
      expect(result, _expectedResult);
      verify(() => _pokedexLocalDataSourceMock.getPokedexData(_limit, _offset));
      verifyNoMoreInteractions(_pokedexLocalDataSourceMock);
    }));

    test('Get pokedex data - Repository exception', () async {
      // Given
      when((() => _pokedexLocalDataSourceMock.getPokedexData(_limit, _offset)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokedexData(_limit, _offset),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex data - Unauthorized exception', () async {
      // Given
      when((() => _pokedexLocalDataSourceMock.getPokedexData(_limit, _offset)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokedexData(_limit, _offset),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex data - Unknown expection', () async {
      // Given
      when((() => _pokedexLocalDataSourceMock.getPokedexData(_limit, _offset)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryImpl.getPokedexData(_limit, _offset),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Save pokedex data', (() {
    const List<PokedexBusiness> _pokedexToSave = [
      PokedexBusiness(
          name: 'name',
          picture: 'picture',
          description: 'description',
          types: ['types'])
    ];

    test('Save pokedex data - Success', (() async {
      // Given
      when((() => _pokedexLocalDataSourceMock.savePokedexData(_pokedexToSave)))
          .thenAnswer((invocation) async => Future<void>);

      // Then
      expect(_pokedexRepositoryImpl.savePokedexData(_pokedexToSave),
          isInstanceOf<Future<void>>());
      verify(() => _pokedexLocalDataSourceMock.savePokedexData(_pokedexToSave));
      verifyNoMoreInteractions(_pokedexLocalDataSourceMock);
    }));

    test('Save pokedex data - Repository exception', () async {
      // Given
      when((() => _pokedexLocalDataSourceMock.savePokedexData(_pokedexToSave)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => _pokedexRepositoryImpl.savePokedexData(_pokedexToSave),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Save pokedex data - Unauthorized exception', () async {
      // Given
      when((() => _pokedexLocalDataSourceMock.savePokedexData(_pokedexToSave)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => _pokedexRepositoryImpl.savePokedexData(_pokedexToSave),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Save pokedex data - Unknown expection', () async {
      // Given
      when((() => _pokedexLocalDataSourceMock.savePokedexData(_pokedexToSave)))
          .thenThrow(Unknown());

      // Then
      expect(() => _pokedexRepositoryImpl.savePokedexData(_pokedexToSave),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
