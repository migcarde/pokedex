import 'package:domain/models/pokemon_specie_busines.dart';
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

  const PokemonFlavorEntryResponse({required this.text});

  factory PokemonFlavorEntryResponse.fromJson(Map<String, dynamic> json) =>
      PokemonFlavorEntryResponse(text: json['flavor_text']);

  @override
  List<Object?> get props => [text];
}

extension PokemonSpecieResponseExtensions on PokemonSpecieResponse {
  PokemonSpecieBusiness toDomain() => PokemonSpecieBusiness(
        flavors: flavors.map((flavor) => flavor.toDomain()).toList(),
      );
}

extension PokemonFlavorEntryResponseExtensions on PokemonFlavorEntryResponse {
  PokemonFlavorEntryBusiness toDomain() =>
      PokemonFlavorEntryBusiness(text: text);
}
