import 'package:data/operations/pokedex/pokedex_local_data_source.dart';
import 'package:data/operations/pokedex/pokedex_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class PokedexRemoteDataSourceMock extends Mock
    implements PokedexRemoteDataSource {}

class PokedexLocalDataSourceMock extends Mock
    implements PokedexLocalDataSource {}
