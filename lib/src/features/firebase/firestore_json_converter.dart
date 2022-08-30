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
