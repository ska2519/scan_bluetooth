import '../constants/resources.dart';
import 'loading_animation.dart';

class LoadingStackBody extends HookConsumerWidget {
  const LoadingStackBody(
      {required this.child, required this.isLoading, super.key});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        if (isLoading) const LoadingAnimation(),
      ],
    );
  }
}
