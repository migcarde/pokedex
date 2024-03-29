import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:domain/models/pokedex_business.dart';
import 'package:hive/hive.dart';

class PokedexLocalDataSource {
  static const _pokedexBox = 'pokedexBox';

  final HiveInterface hive;

  PokedexLocalDataSource({required this.hive});

  Future<List<PokedexDataHiveModel>> getPokedexData(
      int limit, int offset) async {
    final pokedexDataBox = await hive.openBox(_pokedexBox);

    return pokedexDataBox.values
        .skip(offset)
        .take(limit)
        .toList()
        .cast<PokedexDataHiveModel>();
  }

  Future<void> savePokedexData(List<PokedexBusiness> pokedexData) async {
    final pokedexDataBox = await hive.openBox(_pokedexBox);
    final pokedexDataHiveModel = pokedexData
        .map(
          (pokemonData) => pokemonData.toHiveModel(),
        )
        .toList();

    await pokedexDataBox.addAll(pokedexDataHiveModel);
  }
}
