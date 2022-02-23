import 'package:domain/models/pokemon_business.dart';
import 'package:equatable/equatable.dart';

class PokemonResponse extends Equatable {
  final String name;
  final String url;

  const PokemonResponse({required this.name, required this.url});

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(name: json['name'], url: json['url']);

  @override
  List<Object?> get props => [name, url];
}

extension PokemonResponseExtensions on PokemonResponse {
  PokemonBusiness toDomain() => PokemonBusiness(name: name, url: url);
}
