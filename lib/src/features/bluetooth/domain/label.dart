// ignore_for_file: provide_deprecation_message

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../authentication/domain/app_user.dart';
import '../../firebase/firestore_json_converter.dart';
import 'bluetooth.dart';

part 'label.g.dart';
part 'label.freezed.dart';

@freezed
class Label with _$Label {
  const factory Label({
    String? deviceId,
    BluetoothDeviceType? type,
    required String name,
    int? rssi,
    required UserId uid,
    String? documentId,
    @TimestampNullableConverter() DateTime? updatedAt,
    @deprecated @TimestampNullableConverter() DateTime? createdAt,
    @deprecated Bluetooth? bluetooth,
    @deprecated AppUser? user,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}
