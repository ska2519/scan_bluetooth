import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';

class UserLabelCount extends HookConsumerWidget {
  const UserLabelCount({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelList = ref.watch(userLabelListStreamProvider);
    final userLabelCount = ref.watch(userLabelCountProvider);
    return labelList.when(
      data: (labelList) => labelList.isEmpty
          ? const SizedBox()
          : FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.svg.icons8Tag.svg(width: Sizes.p20),
                  gapW4,
                  Text('Label ($userLabelCount/${labelList.length})'),
                ],
              ),
              selected: ref.watch(labelFirstProvider),
              onSelected: (onSelected) => ref
                  .read(labelFirstProvider.notifier)
                  .update((state) => onSelected),
            ),
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
