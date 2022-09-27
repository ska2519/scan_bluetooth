import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final currencyFormatterProvider = Provider<NumberFormat>((ref) {
  return NumberFormat.simpleCurrency();
});
