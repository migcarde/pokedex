import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/svg_icons.dart';

class PokemonStatInformation extends StatelessWidget {
  const PokemonStatInformation({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.contentColor,
    required this.value,
  }) : super(key: key);

  final Color backgroundColor;
  final LocalSvgIcons icon;
  final Color contentColor;
  final String value;

  static const _containerSize = 70.0;
  static const _iconPaddingTop = 6.0;
  static const _iconSize = 24.0;
  static const _valuePaddingTop = 4.0;
  static const _valueSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationStyles.circularRadius(
        color: backgroundColor,
        borderRadius: Dimens.circularRadius,
      ),
      width: _containerSize,
      height: _containerSize,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: _iconPaddingTop),
            child: SvgPicture.asset(
              icon.path,
              color: contentColor,
              height: _iconSize,
              width: _iconSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: _valuePaddingTop),
            child: Text(
              value,
              style: TextStyle(
                color: contentColor,
                fontSize: _valueSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
