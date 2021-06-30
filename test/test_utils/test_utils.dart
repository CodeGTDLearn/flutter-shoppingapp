import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';

class TestUtils {
  Finder key(String keyText) {
    return find.byKey(Key(keyText));
  }

  Finder text(String text) {
    return find.text(text);
  }

  Finder iconType(Type widgetType, IconData iconData) {
    return find.widgetWithIcon(widgetType, iconData);
  }

  Finder type(Type widgetType) {
    return find.byType(widgetType);
  }

  Finder iconData(IconData iconData) {
    return find.byIcon(iconData);
  }

  Finder icon(Icon icon) {
    return find
        .byWidgetPredicate((widget) => widget is Icon && widget.icon == icon.icon);
  }

  Duration delay(int seconds) {
    return Duration(seconds: seconds);
  }

  void checkImageTotalOnAView(int numberOfImages) {
    provideMockedNetworkImages(() async {
      expect(find.byType(Image), findsNWidgets(numberOfImages));
    });
  }

  static void globalTearDown() {
    Get.reset();
  }
}
