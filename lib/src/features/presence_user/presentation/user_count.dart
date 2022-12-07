import '../../../constants/resources.dart';
import '../application/presence_user_service.dart';
import '../domain/user_state.dart';

class UserCount extends HookConsumerWidget {
  const UserCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<UserState?>>(
      error: const SizedBox(),
      loading: const SizedBox(),
      value: ref.watch(statusStateOnlineStreamProvider),
      data: (userStateList) {
        final onlineUserStateList =
            userStateList.where((e) => e?.state == 'online').toList();
        final onlineSignInUserStateList = userStateList
            .where((e) => e?.state == 'online' && !e!.isAnonymous)
            .toList();
        return SizedBox(
          width: 30,
          child: Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message:
                'Sign In / Online: ${onlineUserStateList.length} / Total: ${userStateList.length}',
            child: Text(
              onlineSignInUserStateList.length.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        );
      },
    );
  }
}
