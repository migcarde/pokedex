import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';

class BoxDecorationStyles {
  static const double boxOpacity = 0.2;

  static BoxDecoration crystal() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(mediumDimen),
        ),
        color: Colors.black.withOpacity(boxOpacity),
      );
}
