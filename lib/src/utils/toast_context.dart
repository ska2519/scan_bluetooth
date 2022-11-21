import 'package:fluttertoast/fluttertoast.dart';

import '../constants/resources.dart';

final fToastProvider = StateProvider<FToast>((ref) => FToast());

class ToastContext extends HookConsumerWidget {
  const ToastContext(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: colorScheme(context).errorContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Icon(Icons.check),
          // gapW12,
          Text(text),
        ],
      ),
    );
  }
}
