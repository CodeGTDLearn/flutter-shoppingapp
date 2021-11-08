import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FinderUtils {
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
    return find.byWidgetPredicate((widget) => widget is Icon && widget.icon == icon.icon);
  }

  int countItemsFromFinder(Finder finder) {
    // exactly one widget with type "IconButton"
    // zero widgets with type "IconButton"
    // 2 widgets with type "IconButton"

    var wordList = finder.toString().split(" ");

    switch (wordList[0]) {
      case 'exactly':
        return 1;

      case 'zero':
        return 0;

      default:
        return int.parse(wordList[0].toString());
    }
  }
}
