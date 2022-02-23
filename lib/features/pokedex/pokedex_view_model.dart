import 'package:domain/models/pokemon_business.dart';
import 'package:equatable/equatable.dart';

class PokedexViewModel extends Equatable {
  final String name;
  final String picture;

  const PokedexViewModel({required this.name, required this.picture});

  @override
  List<Object?> get props => [name, picture];
}

extension PokedexViewModelExtension on PokemonBusiness {
  PokedexViewModel toViewModel(String picture) => PokedexViewModel(
        name: name,
        picture: picture,
      );
}
