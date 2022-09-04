import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// A [JsonConverter] that adds support for [Timestamp] objects within ODM models.
class FirestoreTimestampConverter extends JsonConverter<Timestamp, Timestamp> {
  const FirestoreTimestampConverter();
  @override
  Timestamp fromJson(Timestamp json) => json;

  @override
  Timestamp toJson(Timestamp object) => object;
}

/// A [JsonConverter] that adds support for [GeoPoint] objects within ODM models.
class FirestoreGeoPointConverter extends JsonConverter<GeoPoint, GeoPoint> {
  const FirestoreGeoPointConverter();
  @override
  GeoPoint fromJson(GeoPoint json) => json;

  @override
  GeoPoint toJson(GeoPoint object) => object;
}

/// A [JsonConverter] that adds support for [DateTime] objects within ODM models.
class FirestoreDateTimeConverter extends JsonConverter<DateTime?, Timestamp?> {
  const FirestoreDateTimeConverter();

  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

class ServerTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const ServerTimestampConverter();

  @override
  DateTime? fromJson(Object? timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
  }

  @override
  Object? toJson(DateTime? date) => date ?? FieldValue.serverTimestamp();
}

class FieldValueIncrementConverter implements JsonConverter<int?, Object?> {
  const FieldValueIncrementConverter();

  @override
  int? fromJson(Object? count) => count is int ? count : null;

  @override
  Object? toJson(int? count) => count ?? FieldValue.increment(1);
}

// ** DTO Sample
// const factory Dto({
//     required String title,
//     @ServerTimestampConverter()
//     @JsonKey(name: constants.startDateKey)
//          DateTime? startDate,
//     @ServerTimestampConverter()
//     @JsonKey(name: constants.endDateKey)
//         DateTime? endDate,
//     @JsonKey(ignore: true) String? id,
//   }) = _Dto;