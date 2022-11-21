import '../constants/resources.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen(this.notice, {super.key});
  final String notice;

  @override
  Widget build(BuildContext context) {
    logger.i('NoticeScreen build');
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(Sizes.p20),
      child: Center(
        child: Text(
          notice,
          style: textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
