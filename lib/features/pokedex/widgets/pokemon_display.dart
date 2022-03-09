import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';

class PokemonDisplay extends StatelessWidget {
  const PokemonDisplay({
    Key? key,
    required this.picture,
  }) : super(key: key);

  final String picture;

  static const double blurSigma = 40.0;
  static const double boxOpacity = 0.2;
  static const double pokemonPictureDimen = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(circularRadius),
        ),
        color: Colors.black.withOpacity(boxOpacity),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(circularRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Image.network(
            picture,
            width: pokemonPictureDimen,
            height: pokemonPictureDimen,
          ),
        ),
      ),
    );
  }
}
