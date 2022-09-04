import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/domain/app_user.dart';
import '../../firebase/firestore_json_converter.dart';

part 'label.g.dart';
part 'label.freezed.dart';

@freezed
class Label with _$Label {
  const factory Label({
    required String name,
    required UserId uid,
    required AppUser user,
    required String bluetoothName,
    required String deviceId,
    required int rssi,
    String? documentId,
    @ServerTimestampConverter() DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}
