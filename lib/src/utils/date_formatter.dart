import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final dateFormatterProvider = Provider<DateFormat>((ref) {
  /// Date formatter to be used in the app.
  return DateFormat.MMMEd();
});
