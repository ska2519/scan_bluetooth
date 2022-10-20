import 'package:flutter/material.dart';

import '../localization/string_hardcoded.dart';

const kDialogDefaultKey = Key('dialog-default-key');

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  String? title,
  Widget? titleWidget,
  Widget? content,
  String? cancelActionText,
  String? defaultActionText = 'OK',
  Widget? defaultActionWidget,
  VoidCallback? onPressed,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : titleWidget,
      content: content,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        // defaultActionWidget ??
        ElevatedButton(
          key: kDialogDefaultKey,
          onPressed: onPressed ?? () => Navigator.of(context).pop(true),
          child: defaultActionWidget ??
              Text(
                defaultActionText!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
        ),
      ],
    ),
  );
}

/// Generic function to show a platform-aware Material or Cupertino error dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: Text(exception.toString()),
      defaultActionText: 'OK'.hardcoded,
    );

Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented'.hardcoded,
    );
