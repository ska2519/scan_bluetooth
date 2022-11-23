import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase/firestore_json_converter.dart';
import 'app_user.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    UserId? uid,
    String? nickname,
    String? aboutMe,
    DateTime? birthday,
    @Default([]) List<String?> interests,
    @Default([]) List<String?> languages,
    @Default([]) List<String?> photoUrls,
    @FirestoreGeoPointConverter() GeoPoint? location,
    @Default(false) bool verified,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
