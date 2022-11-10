import 'package:flutter/material.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/common/pokemon_types_colors.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/common/text_styles.dart';

class PokemonType extends StatelessWidget {
  const PokemonType({
    Key? key,
    required this.type,
  }) : super(key: key);

  final PokemonTypes type;

  static const double blurSigma = 5.0;
  static const double boxOpacity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationStyles.circularRadius(
        color: _getColorFromType(type),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.circularRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.mediumDimen,
            vertical: Dimens.smallestDimen,
          ),
          child: Text(
            type.name.capitalize(),
            style: TextStyles.bold(textColor: Colors.white),
          ),
        ),
      ),
    );
  }

  Color _getColorFromType(PokemonTypes type) {
    switch (type) {
      case PokemonTypes.bug:
        return PokemonTypesColors.bug;
      case PokemonTypes.steel:
        return PokemonTypesColors.steel;
      case PokemonTypes.water:
        return PokemonTypesColors.water;
      case PokemonTypes.dragon:
        return PokemonTypesColors.dragon;
      case PokemonTypes.electric:
        return PokemonTypesColors.electric;
      case PokemonTypes.ghost:
        return PokemonTypesColors.ghost;
      case PokemonTypes.fire:
        return PokemonTypesColors.fire;
      case PokemonTypes.fairy:
        return PokemonTypesColors.fairy;
      case PokemonTypes.ice:
        return PokemonTypesColors.ice;
      case PokemonTypes.fighting:
        return PokemonTypesColors.fighting;
      case PokemonTypes.normal:
        return PokemonTypesColors.normal;
      case PokemonTypes.grass:
        return PokemonTypesColors.grass;
      case PokemonTypes.physic:
        return PokemonTypesColors.physic;
      case PokemonTypes.rock:
        return PokemonTypesColors.rock;
      case PokemonTypes.dark:
        return PokemonTypesColors.dark;
      case PokemonTypes.ground:
        return PokemonTypesColors.earth;
      case PokemonTypes.poison:
        return PokemonTypesColors.poison;
      case PokemonTypes.flying:
        return PokemonTypesColors.flying;
      case PokemonTypes.unknown:
        return Colors.white;
      case PokemonTypes.shadow:
        return PokemonTypesColors.shadow;
    }
  }
}
