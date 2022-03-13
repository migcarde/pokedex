import 'package:domain/models/pokemon_specie_business.dart';
import 'package:equatable/equatable.dart';

class PokemonSpecieResponse extends Equatable {
  final List<PokemonFlavorEntryResponse> flavors;

  const PokemonSpecieResponse({required this.flavors});

  factory PokemonSpecieResponse.fromJson(Map<String, dynamic> json) {
    final flavors = json['flavor_text_entries'] as List<dynamic>;

    return PokemonSpecieResponse(
      flavors: flavors
          .map((flavor) => PokemonFlavorEntryResponse.fromJson(flavor))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [flavors];
}

class PokemonFlavorEntryResponse extends Equatable {
  final String text;
  final PokemonLanguageResponse language;

  const PokemonFlavorEntryResponse({
    required this.text,
    required this.language,
  });

  factory PokemonFlavorEntryResponse.fromJson(Map<String, dynamic> json) =>
      PokemonFlavorEntryResponse(
        text: json['flavor_text'],
        language: PokemonLanguageResponse.fromJson(json['language']),
      );

  @override
  List<Object?> get props => [text];
}

class PokemonLanguageResponse extends Equatable {
  final String name;

  const PokemonLanguageResponse({required this.name});

  factory PokemonLanguageResponse.fromJson(Map<String, dynamic> json) =>
      PokemonLanguageResponse(name: json['name']);

  @override
  List<Object?> get props => [name];
}

extension PokemonSpecieResponseExtensions on PokemonSpecieResponse {
  PokemonSpecieBusiness toDomain() => PokemonSpecieBusiness(
        flavors: flavors.map((flavor) => flavor.toDomain()).toList(),
      );
}

extension PokemonFlavorEntryResponseExtensions on PokemonFlavorEntryResponse {
  PokemonFlavorEntryBusiness toDomain() => PokemonFlavorEntryBusiness(
        text: text,
        language: language.toDomain(),
      );
}

extension PokemonLanguageResponseExtensions on PokemonLanguageResponse {
  PokemonLanguageBusiness toDomain() => PokemonLanguageBusiness(name: name);
}
