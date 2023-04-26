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
}
