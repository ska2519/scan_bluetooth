import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

const double defaultStrokeWidth = 2.5;

class LoadingIndicator extends PlatformWidget {
  const LoadingIndicator({
    super.key,
    this.size = 20,
    this.borderWidth = defaultStrokeWidth,
    this.color,
  });
  final double? size;
  final double? borderWidth;
  final Color? color;

  @override
  Widget? buildWrapper(BuildContext context, Widget child) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: child,
      ),
    );
  }

  @override
  Widget buildCupertino(BuildContext context) {
    return const CupertinoActivityIndicator();
  }

  @override
  Widget buildMaterial(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorScheme.secondary;

    return CircularProgressIndicator(
      strokeWidth: borderWidth! * 2,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
