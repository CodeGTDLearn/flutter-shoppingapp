import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/keys/modules/overview_keys.dart';
import 'package:shopingapp/app/core/texts/messages.dart';
import 'package:shopingapp/app/core/texts/modules/overview_labels.dart';
import 'package:shopingapp/app/modules/overview/components/custom_grid_item/animated_grid_item.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class CustomAppbarTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;
  final _messages = Get.find<Messages>();
  final _labels = Get.find<OverviewLabels>();

  CustomAppbarTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.testUtils,
  });

  Future<void> close_favoritesFilter_popup_tapOutside(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await _open_popup_check_options(tester);

    var popupItemFav = finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    var popupItemAll = finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY);

    await tester.tapAt(Offset(
      uiTestUtils.deviceWidth(tester) * 0,
      uiTestUtils.deviceHeight(tester) * 0.5,
    ));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(popupItemFav, findsNothing);
    expect(popupItemAll, findsNothing);
  }

  Future<void> check_popup_menuitem_enabled_favorites(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await _open_popup_check_options(tester);

    var favProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: OVERVIEW_POPUP_FAVORITE_OPTION_KEY,
    );

    var allProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: OVERVIEW_POPUP_ALL_OPTION_KEY,
    );
    expect(favProps.enabled, true);
    expect(allProps.enabled, false);
  }

  Future<void> check_popup_menuitem_enabled_all(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    // var favButtonStringKey = OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY;
    // if (!isWidgetTest) await tester.tap(finder.key('$favButtonStringKey\0'));
    // if (isWidgetTest) await tester.tap(finder.key('$favButtonStringKey\2'));

    await _open_popup_check_options(tester);

    await tester.tap(finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await _open_popup_check_options(tester);

    var favProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: OVERVIEW_POPUP_FAVORITE_OPTION_KEY,
    );
    var allProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: OVERVIEW_POPUP_ALL_OPTION_KEY,
    );
    expect(favProps.enabled, false);
    expect(allProps.enabled, true);

    await tester.tap(finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> tap_favoritesFilter_noFavoritesFound(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var fav_button_key = OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY;

    if (!isWidgetTest) await tester.tap(finder.key('$fav_button_key\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.iconType(Icons, Icons.favorite), findsNothing);

    await tester.tap(finder.key(OVERVIEW_POPUP_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var favPopupOption = finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    await tester.ensureVisible(favPopupOption);
    await tester.tap(favPopupOption);
    await tester.pump();

    expect(finder.text(_messages.overview_no_favs_yet()), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> tap_favoriteFilterPopup(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var popup = OVERVIEW_POPUP_APPBAR_BUTTON_KEY;

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(popup));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(_labels.label_title_fav()), findsOneWidget);
    expect(finder.type(AnimatedGridItem), findsWidgets);

    await tester.tap(finder.key(popup));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(finder.text(_labels.label_title_appbar()), findsOneWidget);
  }

  Future<void> _open_popup_check_options(tester) async {
    await tester.tap(finder.key(OVERVIEW_POPUP_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.ensureVisible(finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY));
    await tester.ensureVisible(finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY));
  }
}