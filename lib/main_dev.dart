import 'flavors.dart';
import 'runner.dart';

Future<void> main() async {
  F.appFlavor = Flavor.DEV;
  await AppRunner.run(F.appFlavor!);
}
