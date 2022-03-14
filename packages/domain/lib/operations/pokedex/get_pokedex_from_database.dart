import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokedex_local_database_params.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class GetPokedexFromDatabase
    extends BaseUseCase<List<PokedexBusiness>, PokedexLocalDatabaseParams> {
  final PokedexRepository pokedexRepository;

  GetPokedexFromDatabase({required this.pokedexRepository});

  @override
  Future<List<PokedexBusiness>> call(PokedexLocalDatabaseParams params) =>
      pokedexRepository.getPokedexData(params.limit, params.offset);
}
