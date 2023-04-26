import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle normalStyle({double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      color: const Color(0xff3E4057),
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle titleHightLightedStyle({double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontFamily: "Lobster",
      color: color ?? const Color(0xff3E4057),
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle titleUnHightLightedStyle({double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      fontFamily: "Poppins",
      color: const Color(0xffDC5DA0),
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle quoteStyle({double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      fontFamily: "Poppins",
      color: Colors.white,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
