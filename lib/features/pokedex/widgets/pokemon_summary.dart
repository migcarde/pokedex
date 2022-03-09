import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/common/string_extensions.dart';

class PokemonSummary extends StatelessWidget {
  const PokemonSummary({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  static const double blurSigma = 40.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(mediumDimen)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: bigTinyDimen,
                  left: mediumDimen,
                  right: mediumDimen,
                ),
                child: Text(
                  pokemon.name.capitalize(),
                  style: TextStyles.header(
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: bigTinyDimen,
                  left: mediumDimen,
                  right: mediumDimen,
                ),
                child: Text(
                  pokemon.description.capitalize(),
                  style: TextStyles.body(textColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: bigTinyDimen,
                  horizontal: mediumDimen,
                ),
                child: Wrap(
                  spacing: mediumDimen,
                  children: pokemon.types
                      .map((type) => PokemonType(type: type))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
