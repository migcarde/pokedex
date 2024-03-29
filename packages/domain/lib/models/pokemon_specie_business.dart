import 'package:equatable/equatable.dart';

class PokemonSpecieBusiness extends Equatable {
  final List<PokemonFlavorEntryBusiness> flavors;
  final String evolutionChain;

  const PokemonSpecieBusiness({
    required this.flavors,
    required this.evolutionChain,
  });

  @override
  List<Object?> get props => [flavors, evolutionChain];
}

class PokemonFlavorEntryBusiness extends Equatable {
  final String text;
  final PokemonLanguageBusiness language;

  const PokemonFlavorEntryBusiness({
    required this.text,
    required this.language,
  });

  @override
  List<Object?> get props => [text, language];
}

class PokemonLanguageBusiness extends Equatable {
  final String name;

  const PokemonLanguageBusiness({required this.name});

  @override
  List<Object?> get props => [name];
}
