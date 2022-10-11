import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_sizes.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.foregroundColor,
    this.backgroundColor,
    this.isLoading = false,
    this.height = Sizes.p36,
    this.onPressed,
    this.svgAsset,
  });
  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final String? svgAsset;
  final bool isLoading;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    child: svgAsset != null
                        ? SvgPicture.asset(
                            svgAsset!,
                            width: 20,
                            height: 20,
                          )
                        : null,
                  ),
                  Text(text),
                  const SizedBox(width: 40),
                ],
              ),
      ),
    );
  }
}
