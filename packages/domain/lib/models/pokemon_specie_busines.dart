class PokemonSpecieBusiness {
  final List<PokemonFlavorEntryBusiness> flavors;

  const PokemonSpecieBusiness({required this.flavors});
}

class PokemonFlavorEntryBusiness {
  final String? text;

  const PokemonFlavorEntryBusiness({required this.text});
}
