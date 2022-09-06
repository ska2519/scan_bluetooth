import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../constants/resources.dart';

Future<bool?> labelDialog(
    BuildContext context, TextEditingController textEditingCtr) {
  return showAlertDialog(
    context: context,
    cancelActionText: 'Cancel'.hardcoded,
    defaultActionText: '🖋 Make',
    title: 'Label 🏷 ',
    content: ValueListenableBuilder<TextEditingValue>(
      valueListenable: textEditingCtr,
      builder: (context, value, _) {
        return TextField(
          controller: textEditingCtr,
          autofocus: true,
          maxLength: 20,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Bluetooth Label'.hardcoded,
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: textEditingCtr.clear,
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
        );
      },
    ),
  );
}
