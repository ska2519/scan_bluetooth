import 'package:cached_network_image/cached_network_image.dart';

import '../constants/resources.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.radius = 20,
    this.photoUrl,
    this.onTap,
    this.borderColor,
    this.borderWidth,
    this.imageFilePath,
  });

  final String? photoUrl;
  final String? imageFilePath;
  final double radius;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final accountCircle = AccountCircle(radius: radius);
    // borderColor = colorScheme(context).primary;
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: onTap,
      child: photoUrl != null
          ? CachedNetworkImage(
              imageUrl: photoUrl!,
              imageBuilder: (_, imageProvider) => CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundImage: imageProvider,
                radius: radius,
              ),
              placeholder: (context, url) => accountCircle,
              errorWidget: (context, url, error) => accountCircle,
            )
          : accountCircle,
    );
  }
}

class AccountCircle extends StatelessWidget {
  const AccountCircle({this.radius = 20, super.key});

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.account_circle,
        size: radius! * 2,
        color: theme(context).colorScheme.primary,
      ),
    );
  }
}
