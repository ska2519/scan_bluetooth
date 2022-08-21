

// class TickController extends StateNotifier<AsyncValue<void>> {
//   TickController({required this.ticker}) : super(const AsyncData(null)) {
//     _init();
//   }
//   final Ticker ticker;

//   void _init() {
//     state = AsyncData(Tick(ticker: ticker));
//   }

//   // static final provider =
//   //     StateNotifierProvider.family<TickNotifier, AsyncValue<Tick>>(
//   //         (ref, TickerProvider ticker) {
//   //   return TickNotifier(ticker);
//   // });
// }

// final tickControllerProvider =
//     StateNotifierProvider.autoDispose<TickController, AsyncValue<Tick?>>((ref) {
//   return TickController(ref.watch(tickerProvider));
// });

// final scanButtonControllerProvider =
//     StateNotifierProvider.autoDispose<ScanButtonController, AsyncValue<void>>(
//         (ref) {
//   return ScanButtonController(
//     bluetoothService: ref.watch(bluetoothServiceProvider),
//   );
// });
