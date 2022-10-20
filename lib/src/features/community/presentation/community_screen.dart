import '../../../constants/resources.dart';
import '../../in_app_purchase/presentation/fruit_count.dart';
import '../../presence_user/presentation/user_count_banner.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p4),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              UserCountBanner(),
              FruitCount(),
            ],
          ),
        ),
      ),
    );
  }
}
