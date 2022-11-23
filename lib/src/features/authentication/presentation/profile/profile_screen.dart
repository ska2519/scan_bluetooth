import '../../../../constants/resources.dart';
import '../../data/auth_repository.dart';
import '../../domain/app_user.dart';
import 'profile_submit_form.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen(this.uid, {super.key});
  final UserId uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'.hardcoded),
        ),
        body: AsyncValueWidget<AppUser?>(
          value: ref.watch(fetchAppUserProvider(uid)),
          data: (user) => user == null
              ? const Text('User not found')
              : ProfileSubmitForm(user),
        ),
      ),
    );
  }
}
