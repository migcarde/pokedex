import 'package:bloc_test/bloc_test.dart';
import 'package:data/network/repository_failure.dart';
import 'package:domain/models/base_pagination_business.dart';
import 'package:domain/models/pagination_params_business.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokedex_local_database_params.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/base/base_pagination_view_model.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

import 'pokedex_cubit_mocks.dart';

void main() {
  late MockGetPokedex getPokedex;
  late MockGetPokedexByUrl getPokedexByUrl;
  late MockGetPokemonDetails getPokemonDetails;
  late MockGetPokemonDescription getPokemonDescription;
  late MockGetPokedexFromDatabase getPokedexFromDatabase;
  late MockSavePokedexToDatabase savePokedexToDatabase;
  late PokedexCubit cubit;

  setUp((() {
    getPokedex = MockGetPokedex();
    getPokedexByUrl = MockGetPokedexByUrl();
    getPokemonDetails = MockGetPokemonDetails();
    getPokemonDescription = MockGetPokemonDescription();
    getPokedexFromDatabase = MockGetPokedexFromDatabase();
    savePokedexToDatabase = MockSavePokedexToDatabase();
    cubit = PokedexCubit(
      getPokedex: getPokedex,
      getPokedexByUrl: getPokedexByUrl,
      getPokemonDetails: getPokemonDetails,
      getPokemonDescription: getPokemonDescription,
      getPokedexFromDatabase: getPokedexFromDatabase,
      savePokedexToDatabase: savePokedexToDatabase,
    );
  }));

  tearDown((() {
    cubit.close();
  }));

  blocTest<PokedexCubit, PokedexState>(
    'emits [] when nothing is called.',
    build: () => cubit,
    expect: () => [],
  );

  group('Get pokemons', (() {
    const getPokedexFromDatabaseParams =
        PokedexLocalDatabaseParams(limit: 1, offset: 0);
    const getPokedexParams = PaginationParamsBusiness(offset: 0, limit: 1);
    const expectedEmptyResult =
        BasePaginationViewModel<PokedexViewModel>(count: 0, results: []);
    const expectedDataResult =
        BasePaginationViewModel<PokedexViewModel>(count: 1, results: [
      PokedexViewModel(
        name: 'name',
        picture: 'picture',
        description: 'description',
        types: [PokemonTypes.bug],
        stats: [],
        evolutionChain: 'evolution chain',
        pokemonForm: 'pokemon form',
      )
    ]);
    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexData] when getPokedex is called with empty local database.',
      build: () {
        const List<PokedexBusiness> expectedLocalDatabaseResponse = [];
        const expectedRemoteResult =
            BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);
        when(() => getPokedexFromDatabase.call(getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => expectedLocalDatabaseResponse);
        when(() => getPokedex(getPokedexParams))
            .thenAnswer((invocation) async => expectedRemoteResult);
        when(() => savePokedexToDatabase(expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [PokedexData(data: expectedEmptyResult)],
    );

    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexError] when getPokedex throws Repository exception.',
      build: () {
        const List<PokedexBusiness> expectedLocalDatabaseResponse = [];
        when(() => getPokedexFromDatabase.call(getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => expectedLocalDatabaseResponse);
        when(() => getPokedex(getPokedexParams))
            .thenThrow((invocation) async => RepositoryException());
        when(() => savePokedexToDatabase(expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [
        PokedexError(
            message: 'Opps, something is wrong. Please, try again later')
      ],
    );

    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexError] when getPokedex throws Unauthorized exception.',
      build: () {
        const List<PokedexBusiness> expectedLocalDatabaseResponse = [];
        when(() => getPokedexFromDatabase.call(getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => expectedLocalDatabaseResponse);
        when(() => getPokedex(getPokedexParams))
            .thenThrow((invocation) async => Unauthorized());
        when(() => savePokedexToDatabase(expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [
        PokedexError(
            message: 'Opps, something is wrong. Please, try again later')
      ],
    );

    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexError] when getPokedex throws Unknown exception.',
      build: () {
        const List<PokedexBusiness> expectedLocalDatabaseResponse = [];
        when(() => getPokedexFromDatabase.call(getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => expectedLocalDatabaseResponse);
        when(() => getPokedex(getPokedexParams))
            .thenThrow((invocation) async => Unauthorized());
        when(() => savePokedexToDatabase(expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [
        PokedexError(
            message: 'Opps, something is wrong. Please, try again later')
      ],
    );

    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexData] when getPokedex is called with data in local database.',
      build: () {
        const List<PokedexBusiness> expectedLocalDatabaseResponse = [
          PokedexBusiness(
              name: 'name',
              picture: 'picture',
              description: 'description',
              types: ['types'],
              stats: [],
              evolutionChain: 'evolution chain',
              pokemonForm: 'pokemon form')
        ];
        when(() => getPokedexFromDatabase.call(getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => expectedLocalDatabaseResponse);

        return cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [PokedexData(data: expectedDataResult)],
    );
  }));
}
