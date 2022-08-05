// import 'package:bluetooth_on_my_body/src/common_widgets/async_value_widget.dart';
// import 'package:bluetooth_on_my_body/src/common_widgets/empty_placeholder_widget.dart';
// import 'package:bluetooth_on_my_body/src/common_widgets/responsive_center.dart';
// import 'package:bluetooth_on_my_body/src/constants/common.dart';
// import 'package:bluetooth_on_my_body/src/features/bluetooth/data/bluetooth_repository.dart';
// import 'package:bluetooth_on_my_body/src/features/bluetooth/presentation/home_app_bar/home_app_bar.dart';
// import 'package:bluetooth_on_my_body/src/localization/string_hardcoded.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quick_blue/models.dart';

// /// Shows the product page for a given product ID.
// class BluetoothScreen extends StatelessWidget {
//   const BluetoothScreen({super.key, required this.deviceId});
//   final String deviceId;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const HomeAppBar(),
//       body: Consumer(
//         builder: (context, ref, _) {
//           // final bluetoothValue = ref.watch(bluetoothProvider(deviceId));
//           return AsyncValueWidget<BlueScanResult?>(
//             value: bluetoothValue,
//             data: (bluetooth) => bluetooth == null
//                 ? EmptyPlaceholderWidget(
//                     message: 'Bluetooth not found'.hardcoded,
//                   )
//                 : CustomScrollView(
//                     slivers: [
//                       ResponsiveSliverCenter(
//                         padding: const EdgeInsets.all(Sizes.p16),
//                         child: BluetoothDetails(bluetooth: bluetooth),
//                       ),
//                       // ProductReviewsList(productId: productId),
//                     ],
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }

// /// Shows all the product details along with actions to:
// /// - leave a review
// /// - add to cart
// class BluetoothDetails extends ConsumerWidget {
//   const BluetoothDetails({super.key, required this.bluetooth});
//   final Product bluetooth;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final priceFormatted =
//         ref.watch(currencyFormatterProvider).format(bluetooth.price);
//     return ResponsiveTwoColumnLayout(
//       startContent: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(Sizes.p16),
//           child: CustomImage(imageUrl: bluetooth.imageUrl),
//         ),
//       ),
//       spacing: Sizes.p16,
//       endContent: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(Sizes.p16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(bluetooth.title,
//                   style: Theme.of(context).textTheme.headline6),
//               gapH8,
//               Text(bluetooth.description),
//               // Only show average if there is at least one rating
//               if (bluetooth.numRatings >= 1) ...[
//                 gapH8,
//                 ProductAverageRating(bluetooth: bluetooth),
//               ],
//               gapH8,
//               const Divider(),
//               gapH8,
//               Text(priceFormatted,
//                   style: Theme.of(context).textTheme.headline5),
//               gapH8,
//               LeaveReviewAction(deviceId: bluetooth.id),
//               const Divider(),
//               gapH8,
//               AddToCartWidget(bluetooth: bluetooth),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
