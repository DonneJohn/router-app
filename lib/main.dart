import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hg_router/ui/app.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0,
      // number of method calls to be displayed
      errorMethodCount: 5,
      // number of method calls if stacktrace is provided
      lineLength: 150,
      // width of the output
      colors: false,
      // Colorful log messages
      printEmojis: false,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///init log level
  Logger.level = Level.verbose;
  await SpUtil.getInstance();
//  debugPaintSizeEnabled = true;
  ///init timezone
  var byteData = await rootBundle.load('packages/timezone/data/2019b.tzf');
  var asUint8List = byteData.buffer.asUint8List();
  initializeDatabase(asUint8List);
  runApp(
    App(),
  );
}
