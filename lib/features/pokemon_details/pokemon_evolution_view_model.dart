import 'package:equatable/equatable.dart';

class PokemonEvolutionViewModel extends Equatable {
  final String name;
  final String picture;
  final List<PokemonEvolutionViewModel> evolvesTo;

  const PokemonEvolutionViewModel({
    required this.name,
    required this.picture,
    required this.evolvesTo,
  });

  @override
  List<Object?> get props => [
        name,
        picture,
        evolvesTo,
      ];
}
