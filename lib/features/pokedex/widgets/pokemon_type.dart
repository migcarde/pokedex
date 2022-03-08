import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';

class PokemonType extends StatelessWidget {
  const PokemonType({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  static const double blurSigma = 5.0;
  static const double boxOpacity = 0.2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(circularRadius),
        ),
        color: Colors.white.withOpacity(boxOpacity),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: mediumDimen,
        ),
        child: Text(
          type,
          style: TextStyles.bold(textColor: Colors.white),
        ),
      ),
    );
  }
}
