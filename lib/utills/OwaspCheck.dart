import '../config/owaspRegexInputs.dart';

class Owasp {
  bool isUrlClean(String input) {
    var result =
        new RegExp(SAFE_URL, caseSensitive: false).firstMatch(input.trim());
    return result != null;
  }

  bool isSafeText(String input) {
    var result =
        new RegExp(SAFE_TEXT, caseSensitive: false).firstMatch(input.trim());
    return result != null;
  }

  bool isSafeNumber(String input) {
    var result =
        new RegExp(SAFE_NUMBER, caseSensitive: false).firstMatch(input.trim());
    return result != null;
  }
}
