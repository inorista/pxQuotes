import 'package:flutter/material.dart';

class MethodUtils {
  SnackBar getSnackBar({
    required Widget content,
    SnackBarAction? snackBarAction,
    required DismissDirection dismissDirection,
    EdgeInsetsGeometry? padding,
  }) =>
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        content: content,
        action: snackBarAction,
        dismissDirection: dismissDirection,
        padding: padding,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      );

  // DARKEN COLOR
  Color darken(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
