import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/domain/app_user.dart';
import '../../firebase/firestore_json_converter.dart';

part 'user_state.g.dart';
part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    required String state,
    @JsonKey(name: 'last_changed') @TimestampConverter() DateTime? lastCanged,
    @JsonKey(name: 'is_anonymous') required bool isAnonymous,
    UserId? uid,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);
}
