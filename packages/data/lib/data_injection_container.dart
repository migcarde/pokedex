import 'package:data/operations/pokedex/pokedex_local_data_source.dart';
import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:data/operations/pokedex/pokedex_repository_impl.dart';
import 'package:data/operations/pokedex/pokedex_service.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final locator = GetIt.instance;

void init() {
  // Repository
  locator.registerLazySingleton<PokedexRepository>(() => PokedexRepositoryImpl(
        pokedexRemoteDataSource: locator(),
        pokedexLocalDataSource: locator(),
      ));

  // Remote data source
  locator.registerLazySingleton<PokedexRemoteDataSource>(
      () => PokedexRemoteDataSource(service: locator()));

  // Local data source
  locator.registerLazySingleton<PokedexLocalDataSource>(
      () => PokedexLocalDataSource(hive: locator()));

  // Service
  locator.registerLazySingleton(() => PokemonService());

  // Local data base
  locator.registerLazySingleton(() => Hive);
}
