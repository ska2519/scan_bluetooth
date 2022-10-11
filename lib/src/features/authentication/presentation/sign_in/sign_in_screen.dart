import '../../../../common_widgets/responsive_scrollable_card.dart';
import '../../../../constants/resources.dart';
import 'email_password/email_password_sign_in_screen.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'.hardcoded)),
      body: ResponsiveScrollableCard(
        child: Column(
          children: [
            // EmailPasswordSignInScreen(),
            Assets.logo.bomb1024White.image(),
            gapH32,
            const SignInButtonList(),
          ],
        ),
      ),
    );
  }
}
