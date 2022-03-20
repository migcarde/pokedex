import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';

class CrystalCard extends StatelessWidget {
  const CrystalCard({
    Key? key,
    required this.child,
    this.boxOpacity = _boxOpacity,
  }) : super(key: key);

  final Widget child;
  final double boxOpacity;

  static const double _blurSigma = 10.0;
  static const double _boxOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationStyles.crystal(
        boxOpacity: boxOpacity,
        borderRadius: Dimens.circularRadius,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.circularRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
          child: child,
        ),
      ),
    );
  }
}
