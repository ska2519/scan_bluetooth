import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../constants/resources.dart';

Future<bool?> labelDialog(
    BuildContext context, TextEditingController textEditingCtr) {
  final textTheme = Theme.of(context).textTheme;
  return showAlertDialog(
    context: context,
    cancelActionText: 'Cancel'.hardcoded,
    defaultActionText: '🖋 Make',
    title: 'Create Label 🏷 ',
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<TextEditingValue>(
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
        Text(
          'verified icon over 70%',
          style: textTheme.caption,
        ),
      ],
    ),
  );
}
