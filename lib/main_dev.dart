import 'flavors.dart';
import 'src/app_startup.dart';

Future<void> main() async {
  F.appFlavor = Flavor.DEV;
  await AppStartup.run(F.appFlavor!);
}
