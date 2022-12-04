import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/domain/app_user.dart';
import '../../firebase/firestore_json_converter.dart';
import 'bluetooth.dart';

part 'label.g.dart';
part 'label.freezed.dart';

@freezed
class Label with _$Label {
  const factory Label({
    required Bluetooth bluetooth,
    required String name,
    required UserId uid,
    required AppUser user,
    String? documentId,
    @TimestampNullableConverter() DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}
