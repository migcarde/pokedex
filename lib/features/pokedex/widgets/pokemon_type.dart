import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';

class PokemonType extends StatelessWidget {
  const PokemonType({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  static const double blurSigma = 5.0;
  static const double boxOpacity = 0.1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationStyles.crystal(boxOpacity: boxOpacity),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.circularRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma,
            sigmaY: blurSigma,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.mediumDimen,
            ),
            child: Text(
              type,
              style: TextStyles.bold(textColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
