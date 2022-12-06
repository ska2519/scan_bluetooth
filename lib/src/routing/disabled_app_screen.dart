import '../common_widgets/primary_button.dart';
import '../constants/resources.dart';

class DisabledAppScreen extends HookConsumerWidget {
  const DisabledAppScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🙇‍♀️ Disabled App - Please update App Version',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              onPressed: () {},
              // () => context.goNamed(AppRoute.bluetooth.name),
              text: '🚀 Update App',
            )
          ],
        ),
      ),
    );
  }
}
