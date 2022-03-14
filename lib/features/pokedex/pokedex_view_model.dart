import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:equatable/equatable.dart';

class PokedexViewModel extends Equatable {
  final String name;
  final String picture;
  final String description;
  final List<String> types;

  const PokedexViewModel(
      {required this.name,
      required this.picture,
      required this.description,
      required this.types});

  @override
  List<Object?> get props => [name, picture];
}

extension PokedexViewModelExtension on PokemonBusiness {
  PokedexViewModel toViewModel(
    String picture,
    List<String> types,
    String description,
  ) =>
      PokedexViewModel(
        name: name,
        picture: picture,
        description: description,
        types: types,
      );
}

extension PokedexViewModelLocalDatabaseExtensionsa on PokedexBusiness {
  PokedexViewModel toViewModel() => PokedexViewModel(
        name: name,
        picture: picture,
        description: description,
        types: types,
      );
}
