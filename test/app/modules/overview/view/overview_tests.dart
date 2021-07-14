import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/snackbarr_keys.dart';
import 'package:shopingapp/app/core/components/snackbarr.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/components/favorites_filter_popup.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/modules/overview/core/overview_texts_icons_provided.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class OverviewTests {
  final bool isWidgetTest;
  final TestUtils testUtils;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;

  OverviewTests({
    this.testUtils,
    this.uiTestUtils,
    this.isWidgetTest,
    this.dbTestUtils,
  });

  Future<void> addProductCheckShopCartIconAndSnackbar(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var firstProductCartIconKey = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var snackbarText = testUtils.text(_products()[1].title);

    await tester.tap(firstProductCartIconKey);
    await tester.tap(firstProductCartIconKey);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text("2"), findsOneWidget);
    expect(snackbarText, findsWidgets);
  }

  Future<void> addProductAndClickUndoInSnackbar(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var cartBtnProduct0 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var firstProductSnackbarText = testUtils.text(_products()[1].title);
    var firstProductSnackbarUndoButton = testUtils.key(CUSTOM_SNACKBAR_BUTTON_KEY);

    await tester.tap(cartBtnProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text("1"), findsOneWidget);
    expect(firstProductSnackbarText, findsWidgets);
    await tester.tap(firstProductSnackbarUndoButton);
    await tester.pump();
    expect(testUtils.text("0"), findsOneWidget);
  }

  Future<void> tapFavoritesFilterNoFavoritesFound(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pump();
    var popup = testUtils.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
    var favoriteFilterOption = testUtils.key(OVERVIEW_FAVORITE_FILTER_FAV_KEY);
    var productFavoriteBtn = testUtils.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\2');

    if (isWidgetTest) await tester.tap(productFavoriteBtn);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNothing);

    await tester.tap(popup);
    await tester.pump(testUtils.delay(DELAY));

    await tester.tap(favoriteFilterOption);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
  }

  Future<void> tapFavoriteFilter(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    var productFavoriteBtn = testUtils.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\1');
    var popup = testUtils.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
    var popupItemFav = testUtils.key(OVERVIEW_FAVORITE_FILTER_FAV_KEY);
    var popupItemAll = testUtils.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    if (!isWidgetTest) await tester.tap(productFavoriteBtn);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    expect(testUtils.type(OverviewGridItem), findsNWidgets(4));

    await tester.tap(popup);
    await tester.pumpAndSettle(testUtils.delay(DELAY + 5));
    await tester.tap(popupItemFav);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsOneWidget);
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    expect(testUtils.type(OverviewGridItem), findsNothing);

    await tester.tap(popup);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(popupItemAll);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    expect(testUtils.type(OverviewGridItem), findsNWidgets(4));
  }

  Future<void> closeFavoriteFilter(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    var popup = testUtils.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
    var popupItemFav = testUtils.key(OVERVIEW_FAVORITE_FILTER_FAV_KEY);
    var popupItemAll = testUtils.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(popup);
    await tester.pumpAndSettle();
    expect(popupItemFav, findsOneWidget);
    expect(popupItemAll, findsOneWidget);
    await tester.tapAt(const Offset(0.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(popupItemFav, findsNothing);
    expect(popupItemAll, findsNothing);
  }

  Future<void> addProduct1_3x_CheckingShopCartIcon(
    tester, {
    List<Product> listProducts,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var favBtnProduct = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var snackTitle = testUtils.text("${listProducts[0].title}$ITEMCART_ADDED");
    await tester.tap(favBtnProduct);
    await tester.tap(favBtnProduct);
    await tester.tap(favBtnProduct);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text("3"), findsOneWidget);
    expect(snackTitle, findsOneWidget);
  }

  Future<void> addMultipleProductsAndCheckShopCartIcon(
    tester, {
    List<Product> listProducts,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    var cartBtnProduct0 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartBtnProduct1 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
    var cartBtnProduct2 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\2");
    var cartBtnProduct3 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\3");

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
    expect(testUtils.text("0"), findsOneWidget);

    await tester.tap(cartBtnProduct0);
    await tester.pump();
    expect(testUtils.text("1"), findsOneWidget);

    await tester.tap(cartBtnProduct1);
    await tester.pump();
    expect(testUtils.text("2"), findsOneWidget);

    await tester.tap(cartBtnProduct2);
    await tester.pump();
    expect(testUtils.text("3"), findsOneWidget);

    await tester.tap(cartBtnProduct3);
    await tester.pump();
    expect(testUtils.text("4"), findsOneWidget);
  }

  Future<void> clickProductCheckDetailsImage(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );
    await tester.pump();

    var keyProduct1 = testUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

    await tester.tap(keyProduct1);

    // check if the page has changed
    await tester.pumpAndSettle(testUtils.delay(3));
    expect(testUtils.text(_products()[0].title.toString()), findsOneWidget);

    testUtils.checkImageTotalInAView(1);
  }

  Future<void> clickProductCheckDetailsText(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );
    await tester.pump();

    var keyProduct1 = testUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

    await tester.pumpAndSettle(testUtils.delay(3));
    // @formatter:off
    tester
        .tap(keyProduct1)
        .then((value) => tester.pumpAndSettle(testUtils.delay(1)))
        .then((value) {
      expect(testUtils.text(_products()[0].title.toString()), findsOneWidget);
      expect(testUtils.text('\$${_products()[0].price}'), findsOneWidget);
      expect(testUtils.text(_products()[0].description.toString()), findsOneWidget);
    });
    // @formatter:on
  }

  void checkOverviewGridItemInOverviewView(tester, {int itemsQtde}) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsTypesQtdeInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: itemsQtde,
    );
  }

  void checkOverviewFavorites(tester, int itemsQtde) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsTypesQtdeInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: itemsQtde,
    );
  }

  Future<void> toggleProductFavoriteButton(tester, {int favoritesAfterToggle}) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var button = testUtils.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

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
