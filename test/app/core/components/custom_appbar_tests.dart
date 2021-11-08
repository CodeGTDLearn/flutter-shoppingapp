import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/tests_properties.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class CustomAppbarTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;

  CustomAppbarTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.testUtils,
  });

  Future<void> check_popup_menuitem_enabled_all(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var popupItemFav = finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    var popupItemAll = finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY);

    await tester.tap(finder.key(OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle();
    expect(tester.getSemantics(popupItemFav), matchesSemantics(isEnabled: true));
    expect(tester.getSemantics(popupItemAll), matchesSemantics(isEnabled: false));
  }

  Future<void> check_popup_menuitem_enabled_favorites(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var popupItemFav = finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    var popupItemAll = finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY);

    await tester.tap(finder.key(OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle();
    expect(tester.getSemantics(popupItemFav), matchesSemantics(isEnabled: false));
    expect(tester.getSemantics(popupItemAll), matchesSemantics(isEnabled: true));
  }

  Future<void> close_favFilterPopup_tapOutside(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var popupItemFav = finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    var popupItemAll = finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY);

    await tester.tap(finder.key(OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle();
    expect(popupItemFav, findsOneWidget);
    expect(popupItemAll, findsOneWidget);
    await tester.tapAt(const Offset(0.0, 300.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(popupItemFav, findsNothing);
    expect(popupItemAll, findsNothing);
  }
}