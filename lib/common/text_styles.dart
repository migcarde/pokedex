import 'package:flutter/material.dart';

class TextStyles {
  static const _headerSize = 18.0;
  static const _bodySize = 14.0;
  static const _baseColor = Colors.black;

  static TextStyle header({
    Color? textColor = _baseColor,
    FontWeight? fontWeight = FontWeight.normal,
  }) =>
      TextStyle(
        color: textColor,
        fontSize: _headerSize,
        fontWeight: fontWeight,
      );

  static TextStyle body({
    Color? textColor = _baseColor,
    FontWeight? fontWeight = FontWeight.normal,
  }) =>
      TextStyle(
        color: textColor,
        fontSize: _bodySize,
        fontWeight: fontWeight,
      );

  static TextStyle bold(
          {Color? textColor = _baseColor, double? fontSize = _bodySize}) =>
      TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );
}
