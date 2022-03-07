class PokemonSpecieBusiness {
  final List<PokemonFlavorEntryBusiness> flavors;

  const PokemonSpecieBusiness({required this.flavors});
}

class PokemonFlavorEntryBusiness {
  final String text;
  final PokemonLanguageBusiness language;

  const PokemonFlavorEntryBusiness({
    required this.text,
    required this.language,
  });
}

class PokemonLanguageBusiness {
  final String name;

  const PokemonLanguageBusiness({required this.name});
}
