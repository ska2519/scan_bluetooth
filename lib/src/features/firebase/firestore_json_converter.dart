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
  Object? toJson(DateTime? date) =>
      date == null ? null : FieldValue.serverTimestamp();
}

class TimestampNullableConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampNullableConverter();

  // @override
  // DateTime? fromJson(Object? timestamp) {
  //   if (timestamp is Timestamp) {
  //     return timestamp.toDate();
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // Object? toJson(DateTime? date) =>
  //     date == null ? null : Timestamp.fromDate(date);
  @override
  DateTime? fromJson(Object? json) => json is Timestamp ? json.toDate() : null;

  @override
  Object? toJson(DateTime? object) =>
      object is DateTime ? Timestamp.fromDate(object) : null;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}

class FieldValueIncrementConverter implements JsonConverter<int?, Object?> {
  const FieldValueIncrementConverter();

  @override
  int? fromJson(Object? count) => count is int ? count : null;

  @override
  Object? toJson(int? count) =>
      count == null ? null : FieldValue.increment(count);
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