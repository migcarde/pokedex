import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class PokedexHiveModel {
  @HiveField(0)
  final int page;
  @HiveField(1)
  final List<PokedexDataHiveModel> pokemons;

  //TODO: Check how to paginate pokemons list

  PokedexHiveModel({required this.page, required this.pokemons});
}
