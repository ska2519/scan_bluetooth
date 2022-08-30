import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'app_exception.dart';

final logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
    noBoxingByDefault: true,
    methodCount: 1,
    errorMethodCount: 1,
  ),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class ErrorLogger {
  void logError(Object e, StackTrace? s) {
    // * This can be replaced with a call to a crash reporting tool of choice
    logger.e('logError', e, s);
  }

  void logAppException(AppException exception) {
    // * This can be replaced with a call to a crash reporting tool of choice
    logger.e('logError: ${exception.details.code}', exception.details.message);
    logger.e('$exception');
  }
}

final errorLoggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});
