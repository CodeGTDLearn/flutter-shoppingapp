import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUtils {

  static Finder key(String key) {
    return find.byKey(ValueKey(key));
  }

  static Finder text(String text) {
    return find.text(text);
  }

  static Finder type(Type button, IconData icon) {
    return find.widgetWithIcon(button, icon);
  }

  static Finder icon(IconData icon) {
    return find.byIcon(icon);
  }

  static Duration delay(int seconds) {
    return Duration(seconds: seconds);
  }
}