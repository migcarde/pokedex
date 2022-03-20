import 'package:get_it/get_it.dart';
import 'package:data/data_injection_container.dart' as data_injection_container;
import 'package:domain/domain_injection_container.dart'
    as domain_injection_container;
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';

final locator = GetIt.instance;

void init() {
  data_injection_container.init();
  domain_injection_container.init();

  // Bloc cubits
  locator.registerFactory<PokedexCubit>(() => PokedexCubit(
        getPokedex: locator(),
        getPokedexByUrl: locator(),
        getPokemonDetails: locator(),
        getPokemonDescription: locator(),
        getPokedexFromDatabase: locator(),
        savePokedexToDatabase: locator(),
      ));
}
