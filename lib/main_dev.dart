import 'flavors.dart';
import 'src/runner.dart';

Future<void> main() async {
  F.appFlavor = Flavor.DEV;
  await AppRunner.run(F.appFlavor!);
}
