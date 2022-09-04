import '../../../../constants/resources.dart';

class RssiIcon extends StatelessWidget {
  const RssiIcon({
    super.key,
    required this.intRssi,
    required this.rssiColor,
  });

  final int intRssi;
  final Color? rssiColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (intRssi < 20)
          Assets.svg.icSignalWeakSka144.svg(
            width: 30,
            color: rssiColor,
          )
        else if (20 <= intRssi && intRssi < 40)
          Assets.svg.icSignalFairSka144.svg(
            width: 30,
            color: rssiColor,
          )
        else if (40 <= intRssi && intRssi < 60)
          Assets.svg.icSignalGoodSka144.svg(
            width: 30,
            color: rssiColor,
          )
        else if (60 <= intRssi && intRssi < 80)
          Assets.svg.icSignalStrongSka144.svg(
            width: 30,
            color: rssiColor,
          )
        else if (80 <= intRssi)
          Assets.svg.icSignalSka144.svg(
            width: 30,
            color: rssiColor,
          ),
      ],
    );
  }
}
