import 'flavors.dart';
import 'src/runner.dart';

Future<void> main() async {
  F.appFlavor = Flavor.PROD;
  await AppRunner.run(F.appFlavor!);
}
