import '../../../../constants/resources.dart';
import '../../application/auth_service.dart';
import '../../domain/sign_in_type.dart';
import 'sign_in_button.dart';

class SignInButtonList extends ConsumerWidget {
  const SignInButtonList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    var loggedInApple = false;
    var loggedInGoogle = false;
    var signInType = SignInType.values.toList();

    if (Platform.isIOS || Platform.isMacOS) {
      signInType.sort((a, b) => a == SignInType.apple ? -1 : 1);
    }
    if (user?.providerData != null) {
      loggedInApple =
          user!.providerData!.any((e) => e.providerId == 'apple.com');
      loggedInGoogle =
          user.providerData!.any((e) => e.providerId == 'google.com');
    }

    if (loggedInApple) signInType.remove(SignInType.apple);
    if (loggedInGoogle) signInType.remove(SignInType.google);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: signInType.map(SignInButton.new).toList(),
    );
  }
}
