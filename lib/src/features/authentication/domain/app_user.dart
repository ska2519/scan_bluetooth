import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.g.dart';
part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    String? email,
    String? displayName,
    bool? emailVerified,
    bool? isAnonymous,
    UserMetadata? metadata,
    String? phoneNumber,
    String? photoURL,
    List<UserInfo>? providerData,
    String? refreshToken,
    String? tenantId,
    @Default([]) List<String> estimateIds,
    @Default(false) bool hasEstimate,
  }) = _AppUser;

  factory AppUser.transformFirebaseUser(User user, {String? displayName}) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: displayName ?? user.displayName,
      photoURL: user.photoURL,
      phoneNumber: user.phoneNumber,
      emailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      metadata: UserMetadata(
        creationTime: user.metadata.creationTime,
        lastSignInTime: user.metadata.lastSignInTime,
      ),
      providerData: [
        for (var providerData in user.providerData)
          UserInfo(
            uid: providerData.uid,
            email: providerData.email,
            displayName: providerData.displayName,
            photoURL: providerData.photoURL,
            phoneNumber: providerData.phoneNumber,
            providerId: providerData.providerId,
          )
      ],
      refreshToken: user.refreshToken,
      tenantId: user.tenantId,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

@freezed
class UserMetadata with _$UserMetadata {
  const factory UserMetadata({
    DateTime? creationTime,
    DateTime? lastSignInTime,
  }) = _UserMetadata;

  factory UserMetadata.fromJson(Map<String, dynamic> json) =>
      _$UserMetadataFromJson(json);
}

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
    String? providerId,
    String? uid,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
