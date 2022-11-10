enum PokemonTypes {
  steel,
  water,
  bug,
  dragon,
  electric,
  ghost,
  fire,
  fairy,
  ice,
  fighting,
  normal,
  grass,
  physic,
  rock,
  dark,
  ground,
  poison,
  flying,
  unknown,
  shadow,
}

extension PokemonTypesStringExtensions on String {
  PokemonTypes getType() {
    if (this == PokemonTypes.bug.name) {
      return PokemonTypes.bug;
    } else if (this == PokemonTypes.dragon.name) {
      return PokemonTypes.dragon;
    } else if (this == PokemonTypes.ground.name) {
      return PokemonTypes.ground;
    } else if (this == PokemonTypes.electric.name) {
      return PokemonTypes.electric;
    } else if (this == PokemonTypes.fairy.name) {
      return PokemonTypes.fairy;
    } else if (this == PokemonTypes.fighting.name) {
      return PokemonTypes.fighting;
    } else if (this == PokemonTypes.fire.name) {
      return PokemonTypes.fire;
    } else if (this == PokemonTypes.ghost.name) {
      return PokemonTypes.ghost;
    } else if (this == PokemonTypes.ice.name) {
      return PokemonTypes.ice;
    } else if (this == PokemonTypes.normal.name) {
      return PokemonTypes.normal;
    } else if (this == PokemonTypes.physic.name) {
      return PokemonTypes.physic;
    } else if (this == PokemonTypes.grass.name) {
      return PokemonTypes.grass;
    } else if (this == PokemonTypes.poison.name) {
      return PokemonTypes.poison;
    } else if (this == PokemonTypes.rock.name) {
      return PokemonTypes.rock;
    } else if (this == PokemonTypes.dark.name) {
      return PokemonTypes.dark;
    } else if (this == PokemonTypes.steel.name) {
      return PokemonTypes.steel;
    } else if (this == PokemonTypes.flying.name) {
      return PokemonTypes.flying;
    } else if (this == PokemonTypes.water.name) {
      return PokemonTypes.water;
    } else if (this == PokemonTypes.shadow.name) {
      return PokemonTypes.shadow;
    } else {
      return PokemonTypes.unknown;
    }
  }
}
