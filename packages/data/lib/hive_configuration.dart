import 'package:data/models/pokedex_data_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initConfiguration() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PokedexDataHiveModelAdapter());
}
