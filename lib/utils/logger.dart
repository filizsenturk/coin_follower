import 'package:coin_follower/utils/stack_trace_formatter.dart';
import 'package:logger/logger.dart';


Logger getLogs() {
  return Logger(
    printer: CustomLogPrinter(),
  );
}

class CustomLogPrinter extends LogPrinter {
  CustomLogPrinter();

  @override
  List<String> log(LogEvent event) {
    try {
      var color = PrettyPrinter.levelColors[event.level];
      var emoji = PrettyPrinter.levelEmojis[event.level];

      String method =
      StackTraceFormatter.formatStackTrace(StackTrace.current, 2, 1)!;
      print(color!("$emoji | $method | ${event.message}"));
      return [];
    } catch (e) {
      return [];
    }
  }
}
