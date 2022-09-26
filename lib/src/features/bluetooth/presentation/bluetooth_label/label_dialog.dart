import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../constants/resources.dart';

Future<bool?> labelDialog(
    BuildContext context, TextEditingController textEditingCtr) {
  final textTheme = Theme.of(context).textTheme;
  return showAlertDialog(
    context: context,
    cancelActionText: 'Cancel'.hardcoded,
    // defaultActionText: '🖋 Create',
    defaultActionWidget: ElevatedButton(
      key: kDialogDefaultKey,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.svg.icons8AddTag.svg(width: Sizes.p24),
          gapW8,
          const Text(
            'Create',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      onPressed: () => Navigator.of(context).pop(true),
    ),
    titleWidget: Row(children: [
      Assets.svg.icons8AddTag.svg(width: Sizes.p24),
      gapW8,
      const Text('Create Label'),
    ]),
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
        Row(
          children: [
            Text(
              'verified icon over 70%',
              style: textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.p4),
              child: Assets.svg.icons8VerifiedAccount.svg(width: Sizes.p20),
            ),
          ],
        ),
      ],
    ),
  );
}
