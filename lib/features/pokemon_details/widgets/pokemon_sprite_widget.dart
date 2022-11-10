import 'package:flutter/material.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/common/text_styles.dart';

class PokemonSpriteWidget extends StatelessWidget {
  const PokemonSpriteWidget({
    Key? key,
    required this.pictureUrl,
    required this.evolutionName,
  }) : super(key: key);

  final String pictureUrl;
  final String evolutionName;

  static const double _borderRadius = 20.0;
  static const double _containerPadding = 14.0;
  static const double _pokemonPictureDimen = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecorationStyles.crystal(borderRadius: _borderRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            pictureUrl,
            width: _pokemonPictureDimen,
            height: _pokemonPictureDimen,
          ),
          Text(
            evolutionName.capitalize(),
            style: TextStyles.header(
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
