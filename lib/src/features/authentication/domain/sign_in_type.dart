import 'package:flutter/material.dart';

enum SignInType {
  google(
    'Sign in with Google',
    true,
    Colors.white,
    Colors.black54,
    'assets/svg/google.svg',
  ),
  apple(
    'Sign in with Apple',
    true,
    Colors.black,
    Colors.white,
    'assets/svg/apple_white.svg',
  );

  const SignInType(
    this.buttonTitle,
    this.isAvailable,
    this.backgroundColor,
    this.textColor,
    this.svgAsset,
  );
  final String buttonTitle;
  final bool isAvailable;
  final Color backgroundColor;
  final Color textColor;
  final String svgAsset;

  @override
  String toString() =>
      'SignInType($buttonTitle, isAvailable: $isAvailable, backgroundColor: $backgroundColor, textColor: $textColor, $svgAsset)';
}
