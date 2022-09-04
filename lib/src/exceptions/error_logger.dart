import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'app_exception.dart';

final logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
    noBoxingByDefault: true,
    methodCount: 0,
    errorMethodCount: 1,
  ),
);

class ErrorLogger {
  void e(Object e, StackTrace? s) {
    // * This can be replaced with a call to a crash reporting tool of choice
    logger.e('logError', e, s);
  }

  void appException(AppException exception) {
    // * This can be replaced with a call to a crash reporting tool of choice
    logger.e('logError: ${exception.details.code}', exception.details.message);
    logger.e('$exception');
  }
}

final loggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});
