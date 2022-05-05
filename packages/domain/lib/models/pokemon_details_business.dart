import 'package:equatable/equatable.dart';

class PokemonDetailsBusiness extends Equatable {
  final PokemonSpriteBusiness sprite;
  final List<PokemonSlotTypeBusiness> slots;
  final PokemonDetailsSpecieBusiness specie;

  const PokemonDetailsBusiness({
    required this.sprite,
    required this.slots,
    required this.specie,
  });

  @override
  List<Object?> get props => [sprite, slots, specie];
}

class PokemonSpriteBusiness extends Equatable {
  final String backDefault;
  final String frontDefault;

  const PokemonSpriteBusiness({
    required this.backDefault,
    required this.frontDefault,
  });

  @override
  List<Object?> get props => [backDefault, frontDefault];
}

class PokemonSlotTypeBusiness extends Equatable {
  final PokemonTypeBusiness type;

  const PokemonSlotTypeBusiness({required this.type});

  @override
  List<Object?> get props => [type];
}

class PokemonTypeBusiness extends Equatable {
  final String name;

  const PokemonTypeBusiness({required this.name});

  @override
  List<Object?> get props => [name];
}

class PokemonDetailsSpecieBusiness extends Equatable {
  final String url;

  const PokemonDetailsSpecieBusiness({required this.url});

  @override
  List<Object?> get props => [url];
}
