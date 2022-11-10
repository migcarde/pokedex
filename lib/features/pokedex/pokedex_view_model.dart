import 'package:domain/models/pokedex_business.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/common/pokemon_types.dart';

class PokedexViewModel extends Equatable {
  final int id;
  final String name;
  final String picture;
  final String description;
  final List<PokemonTypes> types;
  final String species;

  const PokedexViewModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
    required this.species,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        picture,
        description,
        types,
        species,
      ];
}

extension PokedexViewModelLocalDatabaseExtensions on PokedexBusiness {
  PokedexViewModel toViewModel() => PokedexViewModel(
        id: id,
        name: name,
        picture: frontPicture,
        description: description,
        types: types.map((type) => type.getType()).toList(),
        species: species.url,
      );
}
