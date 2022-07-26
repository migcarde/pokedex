import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';

class BoxDecorationStyles {
  static const Color _color = Colors.black;
  static const double _boxOpacity = 0.4;

  static BoxDecoration crystal({
    Color? color = _color,
    double boxOpacity = _boxOpacity,
    double borderRadius = Dimens.mediumDimen,
  }) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        color: color?.withOpacity(boxOpacity),
      );
}
