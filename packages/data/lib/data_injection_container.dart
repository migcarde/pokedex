import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:data/operations/pokedex/pokedex_repository_impl.dart';
import 'package:data/operations/pokedex/pokedex_service.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Repository
  locator.registerLazySingleton<PokedexRepository>(
      () => PokedexRepositoryImpl(pokedexRemoteDataSource: locator()));

  // Remote data source
  locator.registerLazySingleton<PokedexRemoteDataSource>(
      () => PokedexRemoteDataSource(service: locator()));

  // Service
  locator.registerLazySingleton(() => PokemonService());
}
