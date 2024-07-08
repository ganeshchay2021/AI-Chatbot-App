import 'package:flutter/material.dart';

TextStyle myTextStyle(
    {double? fontsize, Color? color, FontWeight fontweight = FontWeight.bold}) {
  return TextStyle(
    fontSize: fontsize,
    color: color,
    fontWeight: fontweight,
  );
}
