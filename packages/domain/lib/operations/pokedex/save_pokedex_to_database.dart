import 'package:domain/base/base_use_case.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:domain/operations/pokedex/pokedex_repository.dart';

class SavePokedexToDatabase extends BaseUseCase<void, List<PokedexBusiness>> {
  final PokedexRepository pokedexRepository;

  SavePokedexToDatabase({required this.pokedexRepository});

  @override
  Future<void> call(List<PokedexBusiness> params) async =>
      pokedexRepository.savePokedexData(params);
}
