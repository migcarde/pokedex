import 'package:domain/models/pokemon_details_business.dart';
import 'package:equatable/equatable.dart';

class PokemonDetailsResponse extends Equatable {
  final PokemonSpriteResponse sprite;

  const PokemonDetailsResponse({required this.sprite});

  factory PokemonDetailsResponse.fromJson(Map<String, dynamic> json) =>
      PokemonDetailsResponse(
        sprite: PokemonSpriteResponse.fromJson(json['sprites']),
      );

  @override
  List<Object?> get props => [sprite];
}

class PokemonSpriteResponse extends Equatable {
  final String backDefault;

  const PokemonSpriteResponse({required this.backDefault});

  factory PokemonSpriteResponse.fromJson(Map<String, dynamic> json) =>
      PokemonSpriteResponse(backDefault: json['back_default']);

  @override
  List<Object?> get props => [backDefault];
}

extension PokemonDetailsResponseExtensions on PokemonDetailsResponse {
  PokemonDetailsBusiness toDomain() =>
      PokemonDetailsBusiness(sprite: sprite.toDomain());
}

extension PokemonSpriteResponseExtensions on PokemonSpriteResponse {
  PokemonSpriteBusiness toDomain() =>
      PokemonSpriteBusiness(backDefault: backDefault);
}
