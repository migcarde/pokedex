import 'package:domain/models/pokedex_business.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'pokedex_data_hive_model.g.dart';

@HiveType(typeId: 0)
class PokedexDataHiveModel extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String picture;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<String> types;

  const PokedexDataHiveModel({
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
  });

  @override
  List<Object?> get props => [name, picture, description, types];
}

extension PokedexHiveModelParser on PokedexDataHiveModel {
  PokedexBusiness toDomain() => PokedexBusiness(
        name: name,
        picture: picture,
        description: description,
        types: types,
      );
}
