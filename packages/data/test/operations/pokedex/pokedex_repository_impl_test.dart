import 'package:data/models/base_pagination_response.dart';
import 'package:data/models/base_url_response.dart';
import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:data/models/pokemon_details_response.dart';
import 'package:data/models/pokemon_evolution_chain_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:data/models/pokemon_specie_response.dart';
import 'package:data/models/pokemon_stats_hive_model.dart';
import 'package:data/network/repository_failure.dart';
import 'package:data/operations/pokedex/pokedex_repository_impl.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'pokedex_repository_impl_mocks.dart';

void main() {
  late PokedexRemoteDataSourceMock pokedexRemoteDataSourceMock;
  late PokedexLocalDataSourceMock pokedexLocalDataSourceMock;
  late PokedexRepositoryImpl pokedexRepositoryImpl;

  setUp(() {
    pokedexRemoteDataSourceMock = PokedexRemoteDataSourceMock();
    pokedexLocalDataSourceMock = PokedexLocalDataSourceMock();
    pokedexRepositoryImpl = PokedexRepositoryImpl(
      pokedexRemoteDataSource: pokedexRemoteDataSourceMock,
      pokedexLocalDataSource: pokedexLocalDataSourceMock,
    );
  });

  group('Get pokemons', (() {
    const offset = 0;
    const limit = 1;

    const BasePaginationResponse<PokemonResponse> expectedResponse =
        BasePaginationResponse<PokemonResponse>(count: 0, results: []);

    const BasePaginationBusiness<PokemonBusiness> expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokemons - Success', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemons(offset, limit)))
          .thenAnswer((invocation) async => expectedResponse);

      // When
      final result = await pokedexRepositoryImpl.getPokemons(offset, limit);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexRemoteDataSourceMock.getPokemons(offset, limit));
      verifyNoMoreInteractions(pokedexRemoteDataSourceMock);
    });

    test('Get pokemons - Repository exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemons(offset, limit)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemons(offset, limit),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex - Unauthorized exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemons(offset, limit)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemons(offset, limit),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex - Unknown expection', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemons(offset, limit)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemons(offset, limit),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
  group('Get pokedex by url', (() {
    const url = 'www.example.com';

    const BasePaginationResponse<PokemonResponse> expectedResponse =
        BasePaginationResponse<PokemonResponse>(count: 0, results: []);

    const BasePaginationBusiness<PokemonBusiness> expectedResult =
        BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);

    test('Get pokedex by url - Success', (() async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonsByUrl(url)))
          .thenAnswer((invocation) async => expectedResponse);

      // When
      final result = await pokedexRepositoryImpl.getPokemonsByUrl(url);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexRemoteDataSourceMock.getPokemonsByUrl(url));
      verifyNoMoreInteractions(pokedexRemoteDataSourceMock);
    }));

    test('Get pokemons by url - Repository exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonsByUrl(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonsByUrl(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex by url - Unauthorized exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonsByUrl(url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonsByUrl(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex by url - Unknown expection', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonsByUrl(url)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonsByUrl(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon', (() {
    const url = 'https://pokeapi.co/api/v2/pokemon/1/';

    const pokemonExpectedSprite = PokemonSpriteResponse(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    const pokemonSlots = [
      PokemonSlotTypeResponse(type: PokemonTypeResponse(name: 'grass')),
      PokemonSlotTypeResponse(type: PokemonTypeResponse(name: 'poison')),
    ];
    const pokemonSpecie = PokemonDetailsSpecieResponse(
        url: 'https://pokeapi.co/api/v2/pokemon-species/1/');
    const pokemonStats = [
      PokemonStatsResponse(
        baseStat: 0,
        effort: 10,
        stat: PokemonStatResponse(name: 'name', url: 'url'),
      ),
    ];
    const expectedResponse = PokemonDetailsResponse(
      id: 1,
      sprite: pokemonExpectedSprite,
      slots: pokemonSlots,
      specie: pokemonSpecie,
      stats: pokemonStats,
    );

    final expectedResult = expectedResponse.toDomain();

    test('Get pokemon - Success', (() async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonByUrl(url)))
          .thenAnswer((invocation) async => expectedResponse);

      // When
      final result = await pokedexRepositoryImpl.getPokemonByUrl(url);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexRemoteDataSourceMock.getPokemonByUrl(url));
      verifyNoMoreInteractions(pokedexRemoteDataSourceMock);
    }));

    test('Get pokemon - Repository exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonByUrl(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonByUrl(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon - Unauthorized exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonByUrl(url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonByUrl(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon - Unknown expection', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonByUrl(url)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonByUrl(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon specie', (() {
    const url = 'https://pokeapi.co/api/v2/pokemon-species/1/';
    const pokemonFlavorEntries = [
      PokemonFlavorEntryResponse(
        text:
            'A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.',
        language: PokemonLanguageResponse(
          name: 'en',
        ),
      ),
    ];
    const evolutionChain =
        BaseUrlResponse(url: 'https://pokeapi.co/api/v2/evolution-chain/1/');
    const expectedResponse = PokemonSpecieResponse(
      flavors: pokemonFlavorEntries,
      evolutionChain: evolutionChain,
    );
    final expectedResult = expectedResponse.toDomain();

    test('Get pokemon specie - Success', (() async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonSpecie(url)))
          .thenAnswer((invocation) async => expectedResponse);

      // When
      final result = await pokedexRepositoryImpl.getPokemonSpecie(url);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexRemoteDataSourceMock.getPokemonSpecie(url));
      verifyNoMoreInteractions(pokedexRemoteDataSourceMock);
    }));

    test('Get pokemon specie - Repository exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonSpecie(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonSpecie(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokemon specie - Unauthorized exception', () async {
      // Given
      when(
        (() => pokedexRemoteDataSourceMock.getPokemonSpecie(url)),
      ).thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonSpecie(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokemon specie - Unknown expection', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonSpecie(url)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonSpecie(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokedex data', (() {
    List<PokedexDataHiveModel> expectedResponse = [
      PokedexDataHiveModel(
        id: 1,
        name: 'example',
        frontPicture: 'frontPicture',
        backPicture: 'backPicture',
        description: 'description',
        types: ['grass'],
        stats: [
          PokemonStatsHiveModel(
            type: PokemonStatsTypeHiveModel.hp,
            value: 0,
          )
        ],
        species: 'species',
      ),
    ];
    const limit = 1;
    const offset = 0;
    final expectedResult =
        expectedResponse.map((pokemon) => pokemon.toDomain()).toList();

    test('Get pokedex data - Success', (() async {
      // Given
      when((() => pokedexLocalDataSourceMock.getPokedexData(limit, offset)))
          .thenAnswer((invocation) async => expectedResponse);

      // When
      final result = await pokedexRepositoryImpl.getPokedexData(limit, offset);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexLocalDataSourceMock.getPokedexData(limit, offset));
      verifyNoMoreInteractions(pokedexLocalDataSourceMock);
    }));

    test('Get pokedex data - Repository exception', () async {
      // Given
      when((() => pokedexLocalDataSourceMock.getPokedexData(limit, offset)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokedexData(limit, offset),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Get pokedex data - Unauthorized exception', () async {
      // Given
      when((() => pokedexLocalDataSourceMock.getPokedexData(limit, offset)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokedexData(limit, offset),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Get pokedex data - Unknown expection', () async {
      // Given
      when((() => pokedexLocalDataSourceMock.getPokedexData(limit, offset)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokedexData(limit, offset),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Save pokedex data', (() {
    const List<PokedexBusiness> pokedexToSave = [
      PokedexBusiness(
        id: 1,
        name: 'name',
        frontPicture: 'frontPicture',
        backPicture: 'backPicture',
        description: 'description',
        types: ['types'],
        stats: [],
        species: PokemonDetailsSpecieBusiness(url: 'url'),
      ),
    ];

    test('Save pokedex data - Success', (() async {
      // Given
      when((() => pokedexLocalDataSourceMock.savePokedexData(pokedexToSave)))
          .thenAnswer((invocation) async => Future<void>);

      // Then
      expect(pokedexRepositoryImpl.savePokedexData(pokedexToSave),
          isInstanceOf<Future<void>>());
      verify(() => pokedexLocalDataSourceMock.savePokedexData(pokedexToSave));
      verifyNoMoreInteractions(pokedexLocalDataSourceMock);
    }));

    test('Save pokedex data - Repository exception', () async {
      // Given
      when((() => pokedexLocalDataSourceMock.savePokedexData(pokedexToSave)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.savePokedexData(pokedexToSave),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Save pokedex data - Unauthorized exception', () async {
      // Given
      when((() => pokedexLocalDataSourceMock.savePokedexData(pokedexToSave)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.savePokedexData(pokedexToSave),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Save pokedex data - Unknown expection', () async {
      // Given
      when((() => pokedexLocalDataSourceMock.savePokedexData(pokedexToSave)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.savePokedexData(pokedexToSave),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon evolutions from id -', (() {
    const id = 1;
    const expectedSpecies = PokemonBusiness(
      name: 'name',
      url: 'url',
    );
    const speciesResponse = PokemonResponse(
      name: 'name',
      url: 'url',
    );
    const chain = EvolutionChainResponse(
      species: speciesResponse,
      evolutionDetails: [],
    );
    const response = PokemonEvolutionChainResponse(
      chain: chain,
    );
    const expectedResult = PokemonEvolutionBusiness(
      species: expectedSpecies,
      evolutionDetails: [],
    );

    test('Success', (() async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutions(id)))
          .thenAnswer((invocation) async => response);

      // When
      final result = await pokedexRepositoryImpl.getPokemonEvolutions(id);

      // Then
      expect(result, expectedResult);
      verify(() => pokedexRemoteDataSourceMock.getPokemonEvolutions(id));
      verifyNoMoreInteractions(pokedexRemoteDataSourceMock);
    }));

    test('Repository exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutions(id)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonEvolutions(id),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Unauthorized exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutions(id)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonEvolutions(id),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Unknown expection', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutions(id)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonEvolutions(id),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));

  group('Get pokemon evolutions from url -', (() {
    const url = 'https://pokeapi.co/api/v2/evolution-chain/1/';
    const expectedSpecies = PokemonBusiness(
      name: 'name',
      url: 'url',
    );
    const speciesResponse = PokemonResponse(
      name: 'name',
      url: 'url',
    );
    const chain = EvolutionChainResponse(
      species: speciesResponse,
      evolutionDetails: [],
    );
    const response = PokemonEvolutionChainResponse(
      chain: chain,
    );
    const expectedResult = PokemonEvolutionBusiness(
      species: expectedSpecies,
      evolutionDetails: [],
    );

    test('Success', (() async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutionsFromUrl(url)))
          .thenAnswer((invocation) async => response);

      // When
      final result =
          await pokedexRepositoryImpl.getPokemonEvolutionsFromUrl(url);

      // Then
      expect(result, expectedResult);
      verify(
          () => pokedexRemoteDataSourceMock.getPokemonEvolutionsFromUrl(url));
      verifyNoMoreInteractions(pokedexRemoteDataSourceMock);
    }));

    test('Repository exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutionsFromUrl(url)))
          .thenThrow(RepositoryException());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonEvolutionsFromUrl(url),
          throwsA(isInstanceOf<RepositoryException>()));
    });

    test('Unauthorized exception', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutionsFromUrl(url)))
          .thenThrow(Unauthorized());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonEvolutionsFromUrl(url),
          throwsA(isInstanceOf<Unauthorized>()));
    });

    test('Unknown expection', () async {
      // Given
      when((() => pokedexRemoteDataSourceMock.getPokemonEvolutionsFromUrl(url)))
          .thenThrow(Unknown());

      // Then
      expect(() => pokedexRepositoryImpl.getPokemonEvolutionsFromUrl(url),
          throwsA(isInstanceOf<Unknown>()));
    });
  }));
}
