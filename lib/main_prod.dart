import 'flavors.dart';
import 'src/app_startup.dart';

Future<void> main() async {
  F.appFlavor = Flavor.PROD;
  await AppStartup.run(F.appFlavor!);
}
