import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
  });
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget? error;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) =>
          error ?? Center(child: ErrorMessageWidget(e.toString())),
      loading: () => loading ?? const SizedBox(),
      // loading ?? const Center(child: CircularProgressIndicator()),
    );
  }
}
