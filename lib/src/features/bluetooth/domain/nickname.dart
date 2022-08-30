import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/domain/app_user.dart';
import '../../firebase/firestore_json_converter.dart';

part 'nickname.g.dart';
part 'nickname.freezed.dart';

@freezed
class Nickname with _$Nickname {
  const factory Nickname({
    required String nickname,
    required AppUser user,
    @FirestoreDateTimeConverter() required DateTime createdAt,
  }) = _Nickname;

  factory Nickname.fromJson(Map<String, dynamic> json) =>
      _$NicknameFromJson(json);
}
