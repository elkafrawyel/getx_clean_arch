import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum ButtonType {
  elevated,
  outlined,
  text,
}

abstract class PlatformButton {
  factory PlatformButton() => GetPlatform.isAndroid ? ShowAndroidButton() : ShowIosButton();

  Widget build({
    ButtonType? buttonType,
    required Widget child,
    required VoidCallback onPressed,
    Color? backgroundColor,
  });
}

class ShowAndroidButton implements PlatformButton {
  @override
  Widget build({
    ButtonType? buttonType,
    required Widget child,
    required VoidCallback onPressed,
    Color? backgroundColor,
  }) {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          child: child,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          child: child,
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(backgroundColor: backgroundColor),
        );
      case ButtonType.text:
        return TextButton(
          child: child,
          onPressed: onPressed,
          style: TextButton.styleFrom(backgroundColor: backgroundColor),
        );

      default:
        return ElevatedButton(
          child: child,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        );
    }
  }
}

class ShowIosButton implements PlatformButton {
  @override
  Widget build({
    required Widget child,
    required VoidCallback onPressed,
    Color? backgroundColor,
    ButtonType? buttonType,
  }) {
    return CupertinoButton(
      child: child,
      onPressed: onPressed,
      color: backgroundColor,
    );
  }
}
