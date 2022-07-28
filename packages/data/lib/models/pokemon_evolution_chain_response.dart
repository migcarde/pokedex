import 'package:data/models/pokemon_details_response.dart';
import 'package:equatable/equatable.dart';

class PokemonEvolutionChain extends Equatable {
  final EvolutionChain chain;

  const PokemonEvolutionChain({required this.chain});

  @override
  List<Object?> get props => [chain];

  factory PokemonEvolutionChain.fromJson(Map<String, dynamic> json) =>
      PokemonEvolutionChain(chain: json['chain']);
}

class EvolutionChain extends Equatable {
  final PokemonStatsResponse species;
  final List<EvolutionChain> evolutionDetails;

  const EvolutionChain({required this.species, required this.evolutionDetails});

  @override
  List<Object?> get props => [evolutionDetails];

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    final List<dynamic> evolutionDetails = json['evolves_to'];

    return EvolutionChain(
      species: json['species'],
      evolutionDetails: evolutionDetails
          .map((details) => EvolutionChain.fromJson(details))
          .toList(),
    );
  }
}
