part of 'pokemon_details_cubit.dart';

enum PokemonDetailsStatus {
  loading,
  success,
  failure,
}

class PokemonDetailsState extends Equatable {
  const PokemonDetailsState({
    this.status = PokemonDetailsStatus.loading,
    this.pokemonDetails,
    this.message = '',
  });

  final PokemonDetailsStatus status;
  final PokemonDetailsViewModel? pokemonDetails;
  final String message;

  @override
  List<Object?> get props => [
        status,
        pokemonDetails,
        message,
      ];

  PokemonDetailsState copyWith({
    PokemonDetailsStatus? status,
    PokemonDetailsViewModel? pokemonDetails,
    String? message,
  }) =>
      PokemonDetailsState(
        status: status ?? this.status,
        pokemonDetails: pokemonDetails ?? this.pokemonDetails,
        message: message ?? this.message,
      );
}
