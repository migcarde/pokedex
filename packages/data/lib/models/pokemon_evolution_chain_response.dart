import 'package:data/models/pokemon_reponse.dart';
import 'package:equatable/equatable.dart';

class PokemonEvolutionChainResponse extends Equatable {
  final EvolutionChainResponse chain;

  const PokemonEvolutionChainResponse({required this.chain});

  @override
  List<Object?> get props => [chain];

  factory PokemonEvolutionChainResponse.fromJson(Map<String, dynamic> json) =>
      PokemonEvolutionChainResponse(
        chain: EvolutionChainResponse.fromJson(
          json['chain'],
        ),
      );
}

class EvolutionChainResponse extends Equatable {
  final PokemonResponse species;
  final List<EvolutionChainResponse> evolutionDetails;

  const EvolutionChainResponse(
      {required this.species, required this.evolutionDetails});

  @override
  List<Object?> get props => [evolutionDetails];

  factory EvolutionChainResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> evolutionDetails = json['evolves_to'];

    return EvolutionChainResponse(
      species: PokemonResponse.fromJson(
        json['species'],
      ),
      evolutionDetails: evolutionDetails.isNotEmpty
          ? evolutionDetails
              .map((details) => EvolutionChainResponse.fromJson(details))
              .toList()
          : [],
    );
  }
}
