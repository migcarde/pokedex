import 'package:flutter/material.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class PokemonDisplay extends StatelessWidget {
  const PokemonDisplay({
    Key? key,
    required this.picture,
    this.pictureSize,
  }) : super(key: key);

  final String picture;
  final double? pictureSize;

  static const double _boxOpacity = 0.1;
  static const double _pokemonPictureDimen = 60.0;

  @override
  Widget build(BuildContext context) {
    return CrystalCard(
      boxOpacity: _boxOpacity,
      child: Image.network(
        picture,
        width: pictureSize ?? _pokemonPictureDimen,
        height: pictureSize ?? _pokemonPictureDimen,
      ),
    );
  }
}
