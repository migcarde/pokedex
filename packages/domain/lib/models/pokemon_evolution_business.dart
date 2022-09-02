import 'package:data/models/pokemon_evolution_chain_response.dart';
import 'package:data/models/pokemon_reponse.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:equatable/equatable.dart';

class PokemonEvolutionBusiness extends Equatable {
  final PokemonBusiness species;
  final List<PokemonEvolutionBusiness> evolutionDetails;

  const PokemonEvolutionBusiness({
    required this.species,
    required this.evolutionDetails,
  });

  @override
  List<Object?> get props => [
        species,
        evolutionDetails,
      ];
}

extension PokemonEvolutionBusinessExtensions on EvolutionChainResponse {
  PokemonEvolutionBusiness toDomain() => PokemonEvolutionBusiness(
        species: species.toDomain(),
        evolutionDetails: evolutionDetails.isNotEmpty
            ? evolutionDetails.map((evolution) => evolution.toDomain()).toList()
            : [],
      );
}
