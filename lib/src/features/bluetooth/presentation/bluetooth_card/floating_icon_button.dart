import '../../../../constants/resources.dart';

class FloatingIconButton extends StatelessWidget {
  const FloatingIconButton({
    super.key,
    required this.onTapLabelEdit,
    required this.child,
  });

  final VoidCallback? onTapLabelEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1,
      onPressed: onTapLabelEdit,
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
