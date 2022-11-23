// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../common_widgets/avatar.dart';
import '../../../../constants/resources.dart';
import '../../domain/app_user.dart';

///  프로필 이미지를 보여주는 서클 아바타 위젯
///
///  노 프로필 아이콘이 placeholder와 errorWidget에 설정되어 있음
class GoProfileScreenUserAvatar extends StatelessWidget {
  const GoProfileScreenUserAvatar({
    super.key,
    required this.user,
    this.uid,
    this.radius = 20,
    this.imageUrl,
    required this.onTap,
  });
  final AppUser? user;
  final String? imageUrl;
  final UserId? uid;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const SizedBox()
        : InkWell(
            borderRadius: BorderRadius.circular(1000),
            onTap: onTap,
            child: Avatar(
              radius: radius,
              photoUrl: imageUrl ??
                  (user!.profiles.isNotEmpty
                      ? user?.profiles[0].photoUrls[0]
                      : null),
            ),
          );
  }
}
