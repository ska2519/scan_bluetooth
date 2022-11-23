import '../constants/resources.dart';
import 'loading_animation.dart';

class LoadingStackBody extends HookConsumerWidget {
  const LoadingStackBody(
      {required this.child, required this.isLoading, super.key});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return AbsorbPointer(
      absorbing: isLoading,
      child: Stack(
        children: [
          child,
          if (isLoading)
            SizedBox(
              height: size.height / 1.2,
              child: const LoadingAnimation(),
            ),
        ],
      ),
    );
  }
}
