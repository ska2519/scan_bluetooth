import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: theme.colorScheme.primary,
        size: 50,
      ),
    );
  }
}
