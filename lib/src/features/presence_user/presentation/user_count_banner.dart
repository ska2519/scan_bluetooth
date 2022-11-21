import 'package:numeral/ext.dart';
import '../../../constants/resources.dart';
import '../application/presence_user_service.dart';
import '../domain/user_state.dart';

class UserCountBanner extends HookConsumerWidget {
  const UserCountBanner({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<UserState>>(
      // error: const SizedBox(),
      value: ref.watch(statusStateOnlineStreamProvider),
      data: (userStateList) {
        final totalCount = userStateList.length.numeral();
        final onlineCount = userStateList
            .where((e) => e.state == 'online')
            .toList()
            .length
            .numeral();

        final onlineSignInCount = userStateList
            .where((e) => e.state == 'online' && !e.isAnonymous)
            .toList()
            .length
            .numeral();

        final countList = [onlineSignInCount, onlineCount, totalCount];
        const countListTitle = ['🫐 Sign In', '🟢 Online', '🔴 Total'];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var i = 0; i < countList.length; i++) ...[
                    Column(
                      children: [
                        Text(
                          countListTitle[i],
                          style: textTheme(context).titleSmall,
                        ),
                        Text(
                          countList[i],
                          style: textTheme(context).bodyMedium,
                        ),
                      ],
                    ),
                  ]
                ]),
          ),
        );
      },
    );
  }
}
