import 'package:cached_network_image/cached_network_image.dart';

import '../constants/resources.dart';
import '../features/authentication/domain/app_user.dart';

///  프로필 이미지를 보여주는 서클 아바타 위젯
///
///  노 프로필 아이콘이 placeholder와 errorWidget에 설정되어 있음
///

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    // required this.imageUrl,
    required this.user,
    this.size = 120,
    this.shape = const CircleBorder(),
    this.placeholderColor,
    this.uid,
  }) : assert((user == null && uid != null) || (user != null && uid == null));
  final AppUser? user;
  // final String? imageUrl;
  final UserId? uid;
  final double size;

  /// A shape of the avatar.
  /// A [CircleBorder] is used by default.
  final ShapeBorder? shape;

  /// A color of the avatar placeholder.
  final Color? placeholderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        borderRadius: BorderRadius.circular(1000),
        onTap: () => context.goNamed(
          AppRoute.profile.name,
          params: {'uid': uid != null ? uid! : user!.uid},
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: shape!),
          clipBehavior: Clip.hardEdge,
          child: user?.photoURL != null
              ? CachedNetworkImage(
                  imageUrl: user!.photoURL!,
                  errorWidget: (context, url, error) => AccountCircle(
                    size: size,
                    placeholderColor: placeholderColor,
                  ),
                )
              : AccountCircle(
                  size: size,
                  placeholderColor: placeholderColor,
                ),
        ),
      ),
    );
  }
}

class AccountCircle extends StatelessWidget {
  const AccountCircle({
    super.key,
    this.size,
    this.placeholderColor,
  });

  final double? size;
  final Color? placeholderColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.account_circle,
        size: size,
        color: placeholderColor,
      ),
    );
  }
}
