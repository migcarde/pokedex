import 'package:bloc_test/bloc_test.dart';
import 'package:data/network/repository_failure.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/models/pokemon_specie_business.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_view_model.dart';
import 'package:pokedex/features/pokemon_details/pokemon_evolution_view_model.dart';

import 'pokemon_details_cubit_mocks.dart';

void main() {
  late MockGetPokemonDetailsById getPokemonDetailsById;
  late MockGetPokemonSpecie getPokemonSpecie;
  late MockGetPokemonEvolutionsFromUrl getPokemonEvolutionsFromUrl;
  late PokemonDetailsCubit cubit;

  setUp(() {
    getPokemonDetailsById = MockGetPokemonDetailsById();
    getPokemonSpecie = MockGetPokemonSpecie();
    getPokemonEvolutionsFromUrl = MockGetPokemonEvolutionsFromUrl();
    cubit = PokemonDetailsCubit(
      getPokemonDetailsById: getPokemonDetailsById,
      getPokemonSpecie: getPokemonSpecie,
      getPokemonEvolutionsFromUrl: getPokemonEvolutionsFromUrl,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('Get pokemon details', () {
    // Base params
    const getPokemonDetailsByIdParams = 1;
    const getPokemonSpecieParams = 'http://www.pokemon-specie.com';
    const getPokemonEvolutionsFromUrlParams =
        'http://www.pokemon-evolutions-from-url.com';

    const pokemonParam = PokedexViewModel(
      id: 1,
      name: 'name',
      picture: 'picture',
      description: 'description',
      types: [],
      species: 'http://www.pokemon-specie.com',
    );

    const mockPokemonDetails = PokemonDetailsBusiness(
      id: 1,
      sprite: PokemonSpriteBusiness(
        backDefault: 'backDefault',
        frontDefault: 'frontDefault',
      ),
      slots: [],
      specie:
          PokemonDetailsSpecieBusiness(url: 'http://www.pokemon-specie.com'),
      stats: [],
    );

    const mockPokemonSpecie = PokemonSpecieBusiness(
      flavors: [],
      evolutionChain: 'http://www.pokemon-evolutions-from-url.com',
    );

    const mockPokemonEvolutionEmpty = PokemonEvolutionBusiness(
        species: PokemonBusiness(
          name: 'name',
          url: '',
        ),
        evolutionDetails: []);

    const mockPokemonEvolution = PokemonEvolutionBusiness(
      species: PokemonBusiness(
        name: 'evolution',
        url: 'http://www.pokemon-evolution-from-url.com/2/',
      ),
      evolutionDetails: [
        PokemonEvolutionBusiness(
          species: PokemonBusiness(
              name: 'name',
              url: 'http://www.pokemon-evolution-from-url.com/3/'),
          evolutionDetails: [],
        ),
      ],
    );

    const mockPokemonEvolutionDetails = PokemonDetailsBusiness(
      id: 2,
      sprite: PokemonSpriteBusiness(
        backDefault: 'backDefault',
        frontDefault: 'frontDefault',
      ),
      slots: [],
      specie:
          PokemonDetailsSpecieBusiness(url: 'http://www.pokemon-specie.com'),
      stats: [],
    );

    const expectedResult = PokemonDetailsViewModel(
      id: 1,
      name: 'Name',
      description: 'Description',
      stats: [],
      backPicture: 'backDefault',
      frontPicture: 'picture',
      evolutions: [],
      types: [],
    );

    const expectedResultWithEvolutions = PokemonDetailsViewModel(
      id: 1,
      name: 'Name',
      description: 'Description',
      stats: [],
      backPicture: 'backDefault',
      frontPicture: 'picture',
      evolutions: [
        PokemonEvolutionViewModel(
          name: 'evolution',
          picture: 'frontDefault',
          evolvesTo: [],
        ),
      ],
      types: [],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when init() is called without evolution details.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenAnswer((invocation) async => mockPokemonEvolutionEmpty);

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.success,
          pokemonDetails: expectedResult,
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when init() is called with evolution details.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenAnswer((invocation) async => mockPokemonEvolution);
        when(
          () => getPokemonDetailsById.call(mockPokemonEvolutionDetails.id),
        ).thenAnswer(
          (invocation) async => mockPokemonEvolutionDetails,
        );

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.success,
          pokemonDetails: expectedResultWithEvolutions,
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsById throws Repository exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenThrow((invocation) async => RepositoryException());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsById throws No internet exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenThrow((invocation) async => NoInternet());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsById throws Unauthorized exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenThrow((invocation) async => Unauthorized());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsById throws Server error exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenThrow((invocation) async => ServerError());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsById throws Unknown exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenThrow((invocation) async => Unknown());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsBySpecie throws Repository exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenThrow((invocation) async => RepositoryException());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsBySpecie throws No internet exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenThrow((invocation) async => NoInternet());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsBySpecie throws Unauthorized exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenThrow((invocation) async => Unauthorized());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsBySpecie throws Server error exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenThrow((invocation) async => ServerError());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.error] when GetPokemonDetailsBySpecie throws Unknown exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenThrow((invocation) async => Unknown());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when GetPokemonEvolutionFromUrl throws Repository Exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenThrow((invocation) async => RepositoryException());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when GetPokemonEvolutionFromUrl throws No internet Exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenThrow((invocation) async => NoInternet());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when GetPokemonEvolutionFromUrl throws Unauthorized Exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenThrow((invocation) async => Unauthorized());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when GetPokemonEvolutionFromUrl throws Server error Exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenThrow((invocation) async => ServerError());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );

    blocTest<PokemonDetailsCubit, PokemonDetailsState>(
      'emits [PokemonDetailsStatus.success] when GetPokemonEvolutionFromUrl throws Unknown Exception.',
      build: () {
        when(() => getPokemonDetailsById.call(getPokemonDetailsByIdParams))
            .thenAnswer((invocation) async => mockPokemonDetails);
        when(() => getPokemonSpecie.call(getPokemonSpecieParams))
            .thenAnswer((invocation) async => mockPokemonSpecie);
        when(
          () => getPokemonEvolutionsFromUrl
              .call(getPokemonEvolutionsFromUrlParams),
        ).thenThrow((invocation) async => Unknown());

        return cubit;
      },
      act: (PokemonDetailsCubit cubit) => cubit.init(pokemonParam),
      expect: () => const <PokemonDetailsState>[
        PokemonDetailsState(
          status: PokemonDetailsStatus.failure,
          message: 'Opps, something was wrong, please, try again later.',
        )
      ],
    );
  });
}
