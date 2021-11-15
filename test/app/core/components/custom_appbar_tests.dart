import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
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
      stringKey: OVERVIEW_POPUP_FAVORITE_OPTION_KEY,
    );

    var allProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      stringKey: OVERVIEW_POPUP_ALL_OPTION_KEY,
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
      stringKey: OVERVIEW_POPUP_FAVORITE_OPTION_KEY,
    );
    var allProps = uiTestUtils.getWidgetProperties<PopupMenuItem>(
      tester,
      stringKey: OVERVIEW_POPUP_ALL_OPTION_KEY,
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

    // NAO REMOVER: TODO: criar metodo que percorre lista toda e varre props
    // ao inves de 4 usar a length do DB de test
    // usar test: add_allProducts_check_shopCartIcon do overview
    // for (var i = 0; i < 4; i++) {
    //   print('$fav_button_key$i');
    //   var iconProps = uiTestUtils.getWidgetProperties<IconButton>(
    //     tester,
    //     stringKey: '$fav_button_key$i',
    //   );
    //   print('Properties: ${iconProps.icon == OV_ICO_FAV}');
    // }
    // var xx = iconButtonProps.icon == OV_ICO_FAV;
    // var xx1 = iconButtonProps.icon == OV_ICO_NOFAV;
    // print('>>>>>>>>>>>>>>>>>>>> ${iconButtonProps.toString}|| $xx|| $xx1');
    // var iconButtonProps = uiTestUtils.getWidgetProperties<IconButton>(
    //   tester,
    //   stringKey: '$fav_button_key\2',
    // );

    // if (isWidgetTest) await tester.tap(finder.key('$fav_button_key\2'));
    if (!isWidgetTest) await tester.tap(finder.key('$fav_button_key\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.iconType(Icons, Icons.favorite), findsNothing);

    await tester.tap(finder.key(OVERVIEW_POPUP_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var favPopupOption = finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    await tester.ensureVisible(favPopupOption);
    await tester.tap(favPopupOption);
    await tester.pump();
    // await tester.pumpAndSettle(testUtils.delay(DELAY)); //<<<< pra rodar testes
    // funcionais tem que descomentar aqui, mas se descomentar qui, os teste de unidade
    // falham

    expect(finder.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
    expect(finder.text(FAVORITES_NOT_FOUND_YET), findsOneWidget);
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
    expect(finder.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsOneWidget);
    expect(finder.type(OverviewGridItem), findsWidgets);

    await tester.tap(finder.key(popup));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
  }

  Future<void> _open_popup_check_options(tester) async {
    await tester.tap(finder.key(OVERVIEW_POPUP_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.ensureVisible(finder.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY));
    await tester.ensureVisible(finder.key(OVERVIEW_POPUP_ALL_OPTION_KEY));
  }
}