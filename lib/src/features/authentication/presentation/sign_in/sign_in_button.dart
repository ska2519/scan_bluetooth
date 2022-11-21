// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../common_widgets/primary_button.dart';
import '../../../../constants/resources.dart';
import '../../domain/sign_in_type.dart';
import '../account/account_screen_controller.dart';

class SignInButton extends ConsumerWidget {
  final SignInType signInType;
  const SignInButton(this.signInType, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PrimaryButton(
        text: signInType.buttonTitle,
        foregroundColor: signInType.textColor,
        backgroundColor: signInType.backgroundColor,
        svgAsset: signInType.svgAsset,
        onPressed: state.isLoading
            ? null
            : () => ref
                .read(accountScreenControllerProvider.notifier)
                .signInWith(signInType),
      ),
    );
  }
}
