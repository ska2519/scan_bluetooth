import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';

class UserLabelCount extends HookConsumerWidget {
  const UserLabelCount({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelList = ref.watch(userLabelListCountProvider);
    final userLabelCount = ref.watch(userLabelCountProvider);
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.svg.icons8Tag.svg(width: Sizes.p20),
          gapW4,
          Text('Label ($userLabelCount/$labelList)'),
        ],
      ),
    );
  }
}
