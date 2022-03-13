import 'package:domain/models/pokemon_details_business.dart';
import 'package:equatable/equatable.dart';

class PokemonDetailsResponse extends Equatable {
  final PokemonSpriteResponse sprite;
  final List<PokemonSlotTypeResponse> slots;
  final PokemonDetailsSpecieResponse specie;

  const PokemonDetailsResponse({
    required this.sprite,
    required this.slots,
    required this.specie,
  });

  factory PokemonDetailsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> slots = json['types'];

    return PokemonDetailsResponse(
      sprite: PokemonSpriteResponse.fromJson(json['sprites']),
      slots:
          slots.map((slot) => PokemonSlotTypeResponse.fromJson(slot)).toList(),
      specie: PokemonDetailsSpecieResponse.fromJson(json['species']),
    );
  }

  @override
  List<Object?> get props => [sprite, slots];
}

class PokemonSpriteResponse extends Equatable {
  final String backDefault;
  final String frontDefault;

  const PokemonSpriteResponse({
    required this.backDefault,
    required this.frontDefault,
  });

  factory PokemonSpriteResponse.fromJson(Map<String, dynamic> json) =>
      PokemonSpriteResponse(
          backDefault: json['back_default'],
          frontDefault: json['front_default']);

  @override
  List<Object?> get props => [backDefault];
}

class PokemonSlotTypeResponse extends Equatable {
  final PokemonTypeResponse type;

  const PokemonSlotTypeResponse({required this.type});

  factory PokemonSlotTypeResponse.fromJson(Map<String, dynamic> json) =>
      PokemonSlotTypeResponse(type: PokemonTypeResponse.fromJson(json['type']));

  @override
  List<Object?> get props => [type];
}

class PokemonTypeResponse extends Equatable {
  final String name;

  const PokemonTypeResponse({required this.name});

  factory PokemonTypeResponse.fromJson(Map<String, dynamic> json) =>
      PokemonTypeResponse(name: json['name']);

  @override
  List<Object?> get props => [name];
}

class PokemonDetailsSpecieResponse extends Equatable {
  final String url;

  const PokemonDetailsSpecieResponse({required this.url});

  factory PokemonDetailsSpecieResponse.fromJson(Map<String, dynamic> json) =>
      PokemonDetailsSpecieResponse(url: json['url']);

  @override
  List<Object?> get props => [url];
}

extension PokemonDetailsResponseExtensions on PokemonDetailsResponse {
  PokemonDetailsBusiness toDomain() => PokemonDetailsBusiness(
        sprite: sprite.toDomain(),
        slots: slots.map((slot) => slot.toDomain()).toList(),
        specie: specie.toDomain(),
      );
}

extension PokemonSpriteResponseExtensions on PokemonSpriteResponse {
  PokemonSpriteBusiness toDomain() => PokemonSpriteBusiness(
        backDefault: backDefault,
        frontDefault: frontDefault,
      );
}

extension PokemonSlotTypeResponseExtensions on PokemonSlotTypeResponse {
  PokemonSlotTypeBusiness toDomain() =>
      PokemonSlotTypeBusiness(type: type.toDomain());
}

extension PokemonTypeResponseExtensions on PokemonTypeResponse {
  PokemonTypeBusiness toDomain() => PokemonTypeBusiness(name: name);
}

extension PokemonSpecieResponseExtensions on PokemonDetailsSpecieResponse {
  PokemonDetailsSpecieBusiness toDomain() =>
      PokemonDetailsSpecieBusiness(url: url);
}
