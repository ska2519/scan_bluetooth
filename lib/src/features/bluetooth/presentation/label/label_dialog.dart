import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../constants/resources.dart';

Future<bool?> labelDialog({
  required BuildContext context,
  required TextEditingController textEditingCtr,
  ScanResult? bluetooth,
}) {
  final textTheme = Theme.of(context).textTheme;
  return showAlertDialog(
    context: context,
    cancelActionText: 'Cancel'.hardcoded,
    defaultActionWidget: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // bluetooth?.userLabel != null
        //     ? Assets.svg.icons8UpdateTag.svg(width: Sizes.p24)
        //     :
        Assets.svg.icons8AddTag.svg(width: Sizes.p24),
        gapW8,
        const Text(
          // bluetooth?.userLabel != null ? 'Update' :

          'Create',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    ),
    titleWidget: Row(
      children: [
        // bluetooth?.userLabel != null
        //     ? Assets.svg.icons8UpdateTag.svg(width: Sizes.p24)
        //     :
        Assets.svg.icons8AddTag.svg(width: Sizes.p24),
        gapW8,
        const Text(
          // bluetooth?.userLabel != null ? 'Update Label' :

          'Create Label',
        ),
      ],
    ),
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
