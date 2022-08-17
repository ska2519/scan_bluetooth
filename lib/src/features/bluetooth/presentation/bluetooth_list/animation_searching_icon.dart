import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimationSearchingIcon extends HookWidget {
  const AnimationSearchingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat();

    return AnimatedBuilder(
      animation: controller,
      child: const Icon(
        Icons.search,
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2.0 * pi,
          child: child,
        );
      },
    );
  }
}
