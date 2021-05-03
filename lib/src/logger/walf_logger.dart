import 'package:logging/logging.dart';

class WalfLogger {
  static Logger logger = Logger("💻 Walf Database");

  static initialize() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
    logger.info("==========Walf Logger Initialized==========");
  }

  static void nullLog(dynamic? data, String message) {
    if (data == null) {
      logger.warning(message);
    }
  }

  static void info(String message) {
    logger.info(message);
  }

  static void warning(String message) {
    logger.info(message);
  }

  static void fine(String message) {
    logger.fine(message);
  }
}
