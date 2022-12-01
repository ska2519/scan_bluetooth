import '../../../../constants/resources.dart';

class FloatingIconButton extends StatelessWidget {
  const FloatingIconButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1,
      onPressed: onPressed,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      mini: true,
      heroTag: null,
      shape: const CircleBorder(),
      splashColor: Colors.lightBlueAccent,
      child: child,
    );
  }
}
