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
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

import 'pokedex_cubit_mocks.dart';

void main() {
  late MockGetPokedex _getPokedex;
  late MockGetPokedexByUrl _getPokedexByUrl;
  late MockGetPokemonDetails _getPokemonDetails;
  late MockGetPokemonDescription _getPokemonDescription;
  late MockGetPokedexFromDatabase _getPokedexFromDatabase;
  late MockSavePokedexToDatabase _savePokedexToDatabase;
  late PokedexCubit _cubit;

  setUp((() {
    _getPokedex = MockGetPokedex();
    _getPokedexByUrl = MockGetPokedexByUrl();
    _getPokemonDetails = MockGetPokemonDetails();
    _getPokemonDescription = MockGetPokemonDescription();
    _getPokedexFromDatabase = MockGetPokedexFromDatabase();
    _savePokedexToDatabase = MockSavePokedexToDatabase();
    _cubit = PokedexCubit(
      getPokedex: _getPokedex,
      getPokedexByUrl: _getPokedexByUrl,
      getPokemonDetails: _getPokemonDetails,
      getPokemonDescription: _getPokemonDescription,
      getPokedexFromDatabase: _getPokedexFromDatabase,
      savePokedexToDatabase: _savePokedexToDatabase,
    );
  }));

  tearDown((() {
    _cubit.close();
  }));

  blocTest<PokedexCubit, PokedexState>(
    'emits [] when nothing is called.',
    build: () => _cubit,
    expect: () => [],
  );

  group('Get pokemons', (() {
    const _getPokedexFromDatabaseParams =
        PokedexLocalDatabaseParams(limit: 1, offset: 0);
    const _getPokedexParams = PaginationParamsBusiness(offset: 0, limit: 1);
    const _expectedEmptyResult =
        BasePaginationViewModel<PokedexViewModel>(count: 0, results: []);
    const _expectedDataResult =
        BasePaginationViewModel<PokedexViewModel>(count: 1, results: [
      PokedexViewModel(
        name: 'name',
        picture: 'picture',
        description: 'description',
        types: ['types'],
      )
    ]);
    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexData] when getPokedex is called with empty local database.',
      build: () {
        const List<PokedexBusiness> _expectedLocalDatabaseResponse = [];
        const _expectedRemoteResult =
            BasePaginationBusiness<PokemonBusiness>(count: 0, results: []);
        when(() => _getPokedexFromDatabase.call(_getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => _expectedLocalDatabaseResponse);
        when(() => _getPokedex(_getPokedexParams))
            .thenAnswer((invocation) async => _expectedRemoteResult);
        when(() => _savePokedexToDatabase(_expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return _cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [PokedexData(data: _expectedEmptyResult)],
    );

    blocTest<PokedexCubit, PokedexState>(
      'emits [PokedexError] when getPokedex throws Repository exception.',
      build: () {
        const List<PokedexBusiness> _expectedLocalDatabaseResponse = [];
        when(() => _getPokedexFromDatabase.call(_getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => _expectedLocalDatabaseResponse);
        when(() => _getPokedex(_getPokedexParams))
            .thenThrow((invocation) async => RepositoryException());
        when(() => _savePokedexToDatabase(_expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return _cubit;
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
        const List<PokedexBusiness> _expectedLocalDatabaseResponse = [];
        when(() => _getPokedexFromDatabase.call(_getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => _expectedLocalDatabaseResponse);
        when(() => _getPokedex(_getPokedexParams))
            .thenThrow((invocation) async => Unauthorized());
        when(() => _savePokedexToDatabase(_expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return _cubit;
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
        const List<PokedexBusiness> _expectedLocalDatabaseResponse = [];
        when(() => _getPokedexFromDatabase.call(_getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => _expectedLocalDatabaseResponse);
        when(() => _getPokedex(_getPokedexParams))
            .thenThrow((invocation) async => Unauthorized());
        when(() => _savePokedexToDatabase(_expectedLocalDatabaseResponse))
            .thenAnswer((invocation) async => Future<void>);

        return _cubit;
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
        const List<PokedexBusiness> _expectedLocalDatabaseResponse = [
          PokedexBusiness(
            name: 'name',
            picture: 'picture',
            description: 'description',
            types: ['types'],
          )
        ];
        when(() => _getPokedexFromDatabase.call(_getPokedexFromDatabaseParams))
            .thenAnswer((invocation) async => _expectedLocalDatabaseResponse);

        return _cubit;
      },
      act: (PokedexCubit cubit) => cubit.getPokemons(offset: 0, limit: 1),
      expect: () => const [PokedexData(data: _expectedDataResult)],
    );
  }));
}
