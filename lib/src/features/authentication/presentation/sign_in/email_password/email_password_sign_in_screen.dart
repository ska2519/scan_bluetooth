import 'package:flutter/services.dart';

import '../../../../../common_widgets/custom_text_button.dart';
import '../../../../../common_widgets/primary_button.dart';
import '../../../../../constants/resources.dart';
import '../sign_in_button.dart';
import '../sign_in_type.dart';
import 'email_password_sign_in_controller.dart';
import 'email_password_sign_in_state.dart';

import 'string_validators.dart';

/// Email & password sign in screen.
/// Wraps the [EmailPasswordSignInContents] widget below with a [Scaffold] and
/// [AppBar] with a title.

/// A widget for email & password authentication, supporting the following:
/// - sign in
/// - register (create an account)
class EmailPasswordSignInScreen extends StatefulHookConsumerWidget {
  const EmailPasswordSignInScreen({
    super.key,
    this.onSignedIn,
    this.formType = EmailPasswordSignInFormType.signIn,
  });
  final EmailPasswordSignInFormType formType;
  final VoidCallback? onSignedIn;
  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  ConsumerState<EmailPasswordSignInScreen> createState() =>
      _EmailPasswordSignInScreenState();
}

class _EmailPasswordSignInScreenState
    extends ConsumerState<EmailPasswordSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(EmailPasswordSignInState state) async {
    setState(() => _submitted = true);
    // only submit the form if validation passes
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(
          emailPasswordSignInControllerProvider(widget.formType).notifier);
      final success = await controller.submit(email, password);
      if (success) {
        widget.onSignedIn?.call();
      }
    }
  }

  void _emailEditingComplete(EmailPasswordSignInState state) {
    if (state.canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete(EmailPasswordSignInState state) {
    if (!state.canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit(state);
  }

  void _updateFormType(EmailPasswordSignInFormType formType) {
    // * Toggle between register and sign in form
    ref
        .read(emailPasswordSignInControllerProvider(widget.formType).notifier)
        .updateFormType(formType);
    // * Clear the password field when doing so
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider(widget.formType)
          .select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state =
        ref.watch(emailPasswordSignInControllerProvider(widget.formType));

    return FocusScope(
      node: _node,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gapH8,
            TextFormField(
              key: EmailPasswordSignInScreen.emailKey,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email'.hardcoded,
                hintText: 'test@test.com'.hardcoded,
                enabled: !state.isLoading,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  !_submitted ? null : state.emailErrorText(email ?? ''),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _emailEditingComplete(state),
              inputFormatters: <TextInputFormatter>[
                ValidatorInputFormatter(
                    editingValidator: EmailEditingRegexValidator()),
              ],
            ),
            gapH8,
            // Password field
            TextFormField(
              key: EmailPasswordSignInScreen.passwordKey,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: state.passwordLabelText,
                enabled: !state.isLoading,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) =>
                  !_submitted ? null : state.passwordErrorText(password ?? ''),
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _passwordEditingComplete(state),
            ),
            gapH8,
            PrimaryButton(
              text: state.primaryButtonText,
              height: 45,
              isLoading: state.isLoading,
              onPressed: state.isLoading ? null : () => _submit(state),
            ),
            gapH8,
            CustomTextButton(
              text: state.secondaryButtonText,
              onPressed: state.isLoading
                  ? null
                  : () => _updateFormType(state.secondaryActionFormType),
            ),

            // signInButtonListWidget
          ],
        ),
      ),
    );
  }
}

class SignInButtonList extends StatelessWidget {
  const SignInButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    var signInTypes = SignInType.values.toList();
    if (Platform.isIOS || Platform.isMacOS) {
      signInTypes.sort((a, b) => a == SignInType.apple ? -1 : 1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: signInTypes.map(SignInButton.new).toList(),
    );
  }
}
