import '../../../constants/resources.dart';
import '../application/presence_user_service.dart';
import '../domain/user_state.dart';

class OnlineUserCount extends HookConsumerWidget {
  const OnlineUserCount({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<UserState>>(
      value: ref.watch(statusStateOnlineStreamProvider),
      data: (userStateList) {
        final onlineUserStateList =
            userStateList.where((e) => e.state == 'online').toList();
        return SizedBox(
          width: 30,
          child: Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: 'Online User / Total: ${userStateList.length}',
            child: Text(
              onlineUserStateList.length.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        );
      },
    );
  }
}
