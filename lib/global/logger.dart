import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 3,
    lineLength: 50,
    methodCount: 0,
  ),
);
