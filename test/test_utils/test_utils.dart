import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUtils {

  Finder key(String key) {
    return find.byKey(Key(key));
  }

  Finder text(String text) {
    return find.text(text);
  }

  Finder type(Type button, IconData icon) {
    return find.widgetWithIcon(button, icon);
  }

  Finder icon(IconData icon) {
    return find.byIcon(icon);
  }

  Duration delay(int seconds) {
    return Duration(seconds: seconds);
  }
}