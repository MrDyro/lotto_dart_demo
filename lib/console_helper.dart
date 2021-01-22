import 'dart:convert';
import 'dart:io';

class ConsoleHelper {
  static String readInput() {
    return stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
  }

  static bool readYesOrNo() {
    final input =
        stdin.readLineSync(encoding: Encoding.getByName('utf-8')).trim();
    return input.contains('ja');
  }
}
