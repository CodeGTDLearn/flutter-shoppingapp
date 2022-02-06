import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/texts/core_messages.dart';
import 'package:shopingapp/app/modules/overview/core/components/custom_grid_item/animated_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_keys.dart';
import 'package:shopingapp/app/modules/overview/core/overview_labels.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
import '../../../../config/utils/finder_utils.dart';
import '../../../../config/utils/tests_utils.dart';
import '../../../../config/utils/ui_test_utils.dart';

class CustomAppbarTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;
  final _messages = Get.find<CoreMessages>();
  final _labels = Get.put(OverviewLabels());
  final _keys = Get.find<OverviewKeys>();

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

    var popupItemFav = finder.key(_keys.k_ov_flt_fav());
    var popupItemAll = finder.key(_keys.k_ov_flt_all());

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
      key: _keys.k_ov_flt_fav(),
    );

    var allProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: _keys.k_ov_flt_all(),
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

    await tester.tap(finder.key(_keys.k_ov_flt_fav()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await _open_popup_check_options(tester);

    var favProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: _keys.k_ov_flt_fav(),
    );
    var allProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      key: _keys.k_ov_flt_all(),
    );
    expect(favProps.enabled, false);
    expect(allProps.enabled, true);

    await tester.tap(finder.key(_keys.k_ov_flt_all()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> tap_favoritesFilter_noFavoritesFound(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var fav_button_key = _keys.k_ov_grd_fav_btn();

    if (!isWidgetTest) await tester.tap(finder.key('$fav_button_key\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.iconType(Icons, Icons.favorite), findsNothing);

    await tester.tap(finder.key(_keys.k_ov06()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var favPopupOption = finder.key(_keys.k_ov_flt_fav());
    await tester.ensureVisible(favPopupOption);
    await tester.tap(favPopupOption);
    await tester.pump();

    expect(finder.text(_messages.overview_no_favs_yet), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> tap_favoriteFilterPopup(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var popup = _keys.k_ov06();

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key('${_keys.k_ov_grd_fav_btn}\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(popup));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(_keys.k_ov_flt_fav()));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(_labels.title_fav()), findsOneWidget);
    expect(finder.type(AnimatedGridItem), findsWidgets);

    await tester.tap(finder.key(popup));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(_keys.k_ov_flt_all()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(finder.text(_labels.title_appbar()), findsOneWidget);
  }

  Future<void> _open_popup_check_options(tester) async {
    await tester.tap(finder.key(_keys.k_ov06()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.ensureVisible(finder.key(_keys.k_ov_flt_fav()));
    await tester.ensureVisible(finder.key(_keys.k_ov_flt_all()));
  }
}