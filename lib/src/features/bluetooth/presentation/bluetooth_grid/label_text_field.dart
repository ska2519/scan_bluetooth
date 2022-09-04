// import 'package:flutter_hooks/flutter_hooks.dart';

// import '../../../../constants/resources.dart';
// import '../../../../utils/dismiss_on_screen_keyboard.dart';
// import '../../domain/bluetooth.dart';

// class LabelTextField extends HookConsumerWidget {
//   const LabelTextField(this.bluetooth, {super.key});
//   final Bluetooth bluetooth;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final textEditingCtr = useTextEditingController()
//       ..addListener(() => dismissOnScreenKeyboard(context));

//     useEffect(() {
//       textEditingCtr.text = bluetooth.userLabel?.name ?? bluetooth.name;
//       return null;
//     }, []);

//     return ValueListenableBuilder<TextEditingValue>(
//       valueListenable: textEditingCtr,
//       builder: (context, value, _) {
//         return TextField(
//           controller: textEditingCtr,
//           autofocus: true,
//           maxLength: 20,
//           decoration: InputDecoration(
//             isDense: true,
//             hintText: 'Bluetooth Label'.hardcoded,
//             suffixIcon: value.text.isNotEmpty
//                 ? IconButton(
//                     onPressed: textEditingCtr.clear,
//                     icon: const Icon(Icons.clear),
//                   )
//                 : null,
//           ),
//         );
//       },
//     );
//   }
// }
