class PokemonDetailsBusiness {
  final PokemonSpriteBusiness sprite;
  final List<PokemonSlotTypeBusiness> slots;
  final PokemonDetailsSpecieBusiness specie;

  const PokemonDetailsBusiness({
    required this.sprite,
    required this.slots,
    required this.specie,
  });
}

class PokemonSpriteBusiness {
  final String backDefault;
  final String frontDefault;

  const PokemonSpriteBusiness({
    required this.backDefault,
    required this.frontDefault,
  });
}

class PokemonSlotTypeBusiness {
  final PokemonTypeBusiness type;

  const PokemonSlotTypeBusiness({required this.type});
}

class PokemonTypeBusiness {
  final String name;

  const PokemonTypeBusiness({required this.name});
}

class PokemonDetailsSpecieBusiness {
  final String url;

  const PokemonDetailsSpecieBusiness({required this.url});
}
