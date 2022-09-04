import 'package:flutter/material.dart';

import '../localization/string_hardcoded.dart';

const kDialogDefaultKey = Key('dialog-default-key');

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  Widget? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
}) async {
  return showDialog(
    context: context,
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ElevatedButton(
          key: kDialogDefaultKey,
          child: Text(
            defaultActionText,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          onPressed: () => Navigator.of(context).pop(true),
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
