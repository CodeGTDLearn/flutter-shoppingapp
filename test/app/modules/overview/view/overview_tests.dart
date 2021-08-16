import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/tests_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class OverviewTests {
  final bool isWidgetTest;
  final TestUtils testUtils;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;

  OverviewTests({
    required this.testUtils,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.dbTestUtils,
  });

  Future add_identicalProduct2x_Check_ShopCartIcon(
    tester, {
    required String addProductButtonKey,
    required String productTitle,
    required int finalTotal,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var firstProductCartIconKey = testUtils.key(addProductButtonKey);
    await tester.tap(firstProductCartIconKey);
    await tester.tap(firstProductCartIconKey);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(finalTotal.toString()), findsOneWidget);
    expect(testUtils.text(productTitle), findsWidgets);
  }

  Future addProduct_click_UndoSnackbar_Check_ShopCartIcon(
    tester, {
    required String addProductButtonKey,
    required String productTitle,
    required String snackbarUndoButtonKey,
    required int finalTotal,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(testUtils.key(addProductButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(productTitle), findsWidgets);
    await tester.tap(testUtils.key(snackbarUndoButtonKey));
    await tester.pump();
    expect(testUtils.text(finalTotal.toString()), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future tap_FavoritesFilter_NoFavoritesFound(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var favPopupOption = testUtils.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    var gridItemFavBtnKey = OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY;

    await tester.pump();
    if (isWidgetTest) {
      await tester.tap(testUtils.key('$gridItemFavBtnKey\0'));
      await tester.pump();
      await tester.tap(testUtils.key('$gridItemFavBtnKey\2'));
    }
    if (!isWidgetTest) await tester.tap(testUtils.key('$gridItemFavBtnKey\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.iconType(Icons, Icons.favorite), findsNothing);

    await tester.tap(testUtils.key(OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.ensureVisible(favPopupOption);
    await tester.tap(favPopupOption);
    await tester.pump();
    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future tap_FavoriteFilterPopup(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );
    var gridItemFavBtnKey = OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY;
    var appbarPopup = OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY;

    await tester.pump();
    if (isWidgetTest) await tester.tap(testUtils.key('$gridItemFavBtnKey\2'));
    if (!isWidgetTest) await tester.tap(testUtils.key('$gridItemFavBtnKey\0'));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(testUtils.key(appbarPopup));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.pump();
    await tester.tap(testUtils.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsOneWidget);
    expect(testUtils.type(OverviewGridItem), findsOneWidget);

    await tester.tap(testUtils.key(appbarPopup));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(testUtils.key(OVERVIEW_POPUP_ALL_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
  }

  Future close_FavoriteFilterPopup(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var popupItemFav = testUtils.key(OVERVIEW_POPUP_FAVORITE_OPTION_KEY);
    var popupItemAll = testUtils.key(OVERVIEW_POPUP_ALL_OPTION_KEY);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(testUtils.key(OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle();
    expect(popupItemFav, findsOneWidget);
    expect(popupItemAll, findsOneWidget);
    await tester.tapAt(const Offset(0.0, 300.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(popupItemFav, findsNothing);
    expect(popupItemAll, findsNothing);
  }

  Future add_identicalProduct3x_Check_ShopCartIcon(
    tester, {
    required String productAddButtonKey,
    required int finalTotal,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var addProductKey = testUtils.key(productAddButtonKey);
    await tester.tap(addProductKey);
    await tester.tap(addProductKey);
    await tester.tap(addProductKey);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(finalTotal.toString()), findsOneWidget);
  }

  Future add_4differentProducts_Check_ShopCartIcon(
    tester, {
    required String firstProductAddButtonKey,
    required int finalTotal,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var cartIconProduct0 = testUtils.key(firstProductAddButtonKey);
    var cartIconProduct1 = testUtils.key(firstProductAddButtonKey.replaceFirst('0', '1'));
    var cartIconProduct2 = testUtils.key(firstProductAddButtonKey.replaceFirst('0', '2'));
    var cartIconProduct3 = testUtils.key(firstProductAddButtonKey.replaceFirst('0', '3'));

    //POSSIBLE TAP-ERROR:
    // "To silence this warning, pass "warnIfMissed: false" to "tap()".
    // To make this warning fatal, set WidgetController.hitTestWarningShouldBeFatal to
    // true.
    // Warning: A call to tap() with finder "exactly one widget with key"
    //SOLUTION:
    // - CHANGE
    //   - 'await tester.pumpAndSettle(testUtils.delay(DELAY));' TO
    //   - 'await tester.pump();'
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(cartIconProduct0);
    await tester.pump();
    await tester.tap(cartIconProduct1);
    await tester.pump();
    await tester.tap(cartIconProduct2);
    await tester.pump();
    await tester.tap(cartIconProduct3);
    await tester.pump();
    expect(testUtils.text(finalTotal.toString()), findsOneWidget);
  }

  Future clickProductCheckDetailsImage(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    var keyProduct1 = testUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

    await tester.tap(keyProduct1);

    // check if the page has changed
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(_products()[0].title.toString()), findsOneWidget);

    testUtils.checkImageTotalInAView(1);
  }

  Future clickProductCheckDetailsText(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    var keyProduct1 = testUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    // @formatter:off
    tester
        .tap(keyProduct1)
        .then((value) => tester.pumpAndSettle(testUtils.delay(DELAY)))
        .then((value) {
      expect(testUtils.text(_products()[0].title.toString()), findsOneWidget);
      expect(testUtils.text('\$${_products()[0].price}'), findsOneWidget);
      expect(testUtils.text(_products()[0].description.toString()), findsOneWidget);
    });
    // @formatter:on
  }

  Future check_OverviewGridItems_In_OverviewView(tester, {required int itemsQtde}) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsQuantityInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: itemsQtde,
    );
  }

  void checkOverviewFavorites(tester, int itemsQtde) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsQuantityInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: itemsQtde,
    );
  }

  Future toggle_ProductFavoriteButton(
    tester, {
    required int favoritesAfterToggle,
    required String toggleButtonKey,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var button = testUtils.key(toggleButtonKey);

    await tester.tap(button);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(
      testUtils.iconType(IconButton, Icons.favorite),
      findsNWidgets(favoritesAfterToggle),
    );
  }

  List<Product> _products() {
    return Get.find<IOverviewService>().getLocalDataAllProducts();
  }
}
