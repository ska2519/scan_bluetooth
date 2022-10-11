// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../common_widgets/primary_button.dart';
import '../../../../constants/resources.dart';
import 'sign_in_button_controller.dart';
import 'sign_in_type.dart';

class SignInButton extends ConsumerWidget {
  final SignInType signInType;
  const SignInButton(this.signInType, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      signInButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInButtonControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PrimaryButton(
        height: 45,
        text: signInType.buttonTitle,
        foregroundColor: signInType.textColor,
        backgroundColor: signInType.backgroundColor,
        svgAsset: signInType.svgAsset,
        isLoading: state.isLoading,
        onPressed: state.isLoading
            ? null
            : () => ref
                .read(signInButtonControllerProvider.notifier)
                .signInWith(signInType),
      ),
    );
  }
}
