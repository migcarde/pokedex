import 'package:hive/hive.dart';

class PokedexLocalDataSource {
  static const pokedexBox = 'pokedexBox';

  final HiveInterface hive;

  PokedexLocalDataSource({required this.hive});

  //TODO: Add getter for pokedex from hive
  //TODO: Add setter from pokedex to hive
}
