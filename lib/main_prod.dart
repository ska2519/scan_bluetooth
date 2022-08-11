import 'flavors.dart';
import 'runner.dart';

Future<void> main() async {
  F.appFlavor = Flavor.PROD;
  await AppRunner.run(F.appFlavor!);
}
