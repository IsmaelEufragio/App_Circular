part of 'http.dart';

void _printLogs(Map<String, dynamic> logs) {
  if (kDebugMode) {
    log('''
🙄
--------------------------------------
${const JsonEncoder.withIndent('  ').convert(logs)}
--------------------------------------
🙄
 ''');
  }
}
