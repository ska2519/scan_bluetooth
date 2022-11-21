import '../../../../constants/resources.dart';
import '../../data/auth_repository.dart';
import '../../domain/app_user.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen(this.uid, {super.key});
  final UserId uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'.hardcoded),
      ),
      body: AsyncValueWidget<AppUser?>(
        value: ref.watch(fetchAppUserProvider(uid)),
        data: (user) {
          return user == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('NickName'),
                          Text(user.displayName ?? ''),
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
