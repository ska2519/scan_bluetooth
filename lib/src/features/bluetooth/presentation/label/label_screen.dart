import '../../../../common_widgets/loading_animation.dart';
import '../../../../common_widgets/loading_stack_body.dart';
import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
import '../../domain/label.dart';
import '../bluetooth_card/bluetooth_card.dart';
import '../bluetooth_grid/bluetooth_layout_grid.dart';
import 'label_screen_controller.dart';

class LabelScreen extends HookConsumerWidget {
  const LabelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      labelScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(labelScreenControllerProvider);
    logger.i(
        'ref.watch(userLabelListCountProvider): ${ref.watch(userLabelListCountProvider)}');
    return LoadingStackBody(
      isLoading: state.isLoading,
      child: AsyncValueWidget<List<Label?>>(
        error: const SizedBox(),
        value: ref.watch(userLabelListStreamProvider),
        data: (labelList) => labelList.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Assets.svg.icons8Tag.svg(height: 20, width: 20),
                  ),
                  gapW4,
                  Text(
                    'No Labels'.hardcoded,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Assets.svg.icons8Tag.svg(height: 24, width: 24),
                      ),
                      gapW8,
                      Text(
                        'My Labels'.hardcoded,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  gapH8,
                  BluetoothLayoutGrid(
                    itemCount: labelList.length,
                    itemBuilder: (_, i) {
                      final bluetooth = labelList[i]!
                          .bluetooth
                          .copyWith(userLabel: labelList[i]);
                      return BluetoothCard(
                        canDelete: true,
                        bluetooth: bluetooth,
                        index: i,
                        onTapLabelEdit: () async {
                          logger.i('onTapLabelEdit');
                          await ref
                              .read(labelScreenControllerProvider.notifier)
                              .onTapLabelEdit(bluetooth, context);
                        },
                      );
                    },
                  ),
                  gapH8,
                ],
              ),
      ),
    );
  }
}

class AsyncValueStackLoadingAnimation extends StatelessWidget {
  const AsyncValueStackLoadingAnimation({
    super.key,
    required this.state,
    required this.child,
  });

  final AsyncValue<void> state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (state.isLoading) const LoadingAnimation(),
      ],
    );
  }
}
