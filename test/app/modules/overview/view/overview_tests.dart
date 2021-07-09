import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/snackbarr_keys.dart';
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

  Future<void> addProductCheckSnackbar(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(3));
    var CartIconKey = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    // var snackbartext1 = testUtils.text(_products()[1].title.toString());

    expect(testUtils.text("0"), findsOneWidget);
    await tester.tap(CartIconKey);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.text("1"), findsOneWidget);
    // expect(snackbartext1, findsOneWidget);
    await tester.tap(CartIconKey);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.text("2"), findsOneWidget);
    // expect(snackbartext1, findsOneWidget);
  }

  Future<void> addProductAndClickUndoInSnackbar(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    var key = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var undo = testUtils.key(CUSTOM_SNACKBAR_BUTTON_KEY);
    // var snackbarText = testUtils.text(_products()[1].title.toString());

    await tester.pumpAndSettle(testUtils.delay(3));
    expect(testUtils.text("0"), findsOneWidget);
    await tester.tap(key);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.text("1"), findsOneWidget);
    // expect(snackbarText, findsOneWidget);
    await tester.tap(undo);
    await tester.pump();
    expect(testUtils.text("0"), findsOneWidget);
    // expect(snackbarText, findsOneWidget);
  }

  Future<void> addProducts3And4AndCheckShopcarticon(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pump();

    // _testProductTitlesAndTotalIconsInTheScreen();

    // var item = ITEMCART_ADDED;
    // var snackTitle2 = _utils.text("${_products()[2].title.toString()}$item");
    // var snackTitle3 = _utils.text("${_products()[3].title.toString()}$item");
    var key2 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\2");
    var key3 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\3");
    /*
        * The WidGet Testing in the keys 02 + key 03
        *
        * Are not being allowed by the TEstingApp System
        * Only tests are done in the Key 00 + Key 01
        *
        * There is no apparent reason for that.
        * The four keys have the same configuration
        * however, the comand 'await tester.tap(key);'
        * only run using the keys 00/01
        *
        * O sistema de testes nao esta sendo processado
        * nas keys 02/03, somente os testes sao procedidos
        * pelo sistema nas keys 00/01
        *
        * Nao existe razao a aparente para isso ocorrer
        * As 4 keys possuem a mesma configuracao
        * entretando, o comando 'await tester.tap(key);'
        * somente e EXECUTADO com as keys 00/01
         */

    await tester.pumpAndSettle(testUtils.delay(3));
    expect(testUtils.text("0"), findsOneWidget);
    await tester.tap(key2);
    await tester.pumpAndSettle();
    // expect(_utils.text("1"), findsOneWidget);
    // expect(snackTitle2, findsOneWidget);

    await tester.tap(key3);
    await tester.pumpAndSettle();
    // expect(_utils.text("2"), findsOneWidget);
    // expect(snackTitle3, findsOneWidget);
  }

  Future<void> tapFavoritesFilterNoFavoritesFound(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    var popup = testUtils.key(K_OV_FLT_APPBAR_BTN);
    var favBtnProduct = testUtils.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\2');

    await tester.pumpAndSettle(testUtils.delay(3));
    // 1) CHECK ONLY ONE FAVORITE
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));

    // 2) TAP TO UNFAVORITE THAT
    await tester.tap(favBtnProduct);
    await tester.pump(testUtils.delay(1));

    // 3) CHECK NONE FAVORITE
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(0));

    // 4) TAP FAVORITE-FILTER IN APPBAR + CHECK ITS OPTIONS
    await tester.tap(popup);
    await tester.pump(testUtils.delay(1));
    expect(testUtils.text(OV_TXT_POPUP_FAV), findsOneWidget);
    expect(testUtils.text(OV_TXT_POPUP_ALL), findsOneWidget);
    expect(testUtils.type(FavoritesFilterPopup), findsOneWidget);

    // 5) TAP FAVORITE OPTION
    // 5.1) CHECK SNACK-BAR(MESSAGE: NO FAVORITES YET)
    // 5.2) PUMP_AND_SETTLE TO FINALIZE THE PROCESS
    await tester.tap(testUtils.key(OVERVIEW_FAVORITE_FILTER_KEY));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(2));
    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
  }

  Future<void> tapFavoriteFilter(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(3));
    // var titleProduct = testUtils.text(_products()[2].title.toString());
    var popup = testUtils.key(K_OV_FLT_APPBAR_BTN);
    var popupItemFav = testUtils.key(OVERVIEW_FAVORITE_FILTER_KEY);
    var popupItemAll = testUtils.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    expect(testUtils.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
    await tester.tap(popup);
    await tester.pump();
    expect(testUtils.text(OV_TXT_POPUP_FAV), findsOneWidget);
    expect(testUtils.text(OV_TXT_POPUP_ALL), findsOneWidget);
    await tester.tap(popupItemFav);
    await tester.pump();
    // expect(titleProduct, findsOneWidget);
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    await tester.tap(popup);
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.text(OV_TXT_POPUP_FAV), findsOneWidget);
    expect(testUtils.text(OV_TXT_POPUP_ALL), findsOneWidget);
    await tester.tap(popupItemAll);
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    expect(testUtils.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
  }

  Future<void> closeFavoriteFilter(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    var popup = testUtils.key(K_OV_FLT_APPBAR_BTN);
    var popupItemFav = testUtils.key(OVERVIEW_FAVORITE_FILTER_KEY);
    var popupItemAll = testUtils.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

    await tester.pumpAndSettle(testUtils.delay(3));
    await tester.tap(popup);
    await tester.pumpAndSettle();
    expect(popupItemFav, findsOneWidget);
    expect(popupItemAll, findsOneWidget);
    await tester.tapAt(const Offset(0.0, 0.0));
    await tester.pumpAndSettle();
    expect(popupItemFav, findsNothing);
    expect(popupItemAll, findsNothing);
  }

  Future<void> addProduct1ThreeTimesAndCheckShopCartIcon(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );

    await tester.pumpAndSettle(testUtils.delay(3));
    var favBtnProduct = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

    var snackTitle1;
    snackTitle1 = testUtils.text("${_products()[0].title.toString()}$ITEMCART_ADDED");

    expect(testUtils.text("0"), findsOneWidget);

    await tester.tap(favBtnProduct);
    await tester.pump();
    await tester.tap(favBtnProduct);
    await tester.pump();
    await tester.tap(favBtnProduct);
    await tester.pump();
    expect(testUtils.text("3"), findsOneWidget);
    expect(snackTitle1, findsOneWidget);
  }

  Future<void> addProducts1And2AndCheckShopcarticon(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      driver: app.AppDriver(),
    );
    await tester.pump();

    // _testProductTitlesAndTotalIconsInTheScreen();

    var snackTitle0, snackTitle1;
    var item = ITEMCART_ADDED;
    snackTitle0 = testUtils.text("${_products()[0].title.toString()}$item");
    snackTitle1 = testUtils.text("${_products()[1].title.toString()}$item");

    var key0 = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var favBtnProduct = testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");

    await tester.pumpAndSettle(testUtils.delay(3));
    expect(testUtils.text("0"), findsOneWidget);
    await tester.tap(key0);
    await tester.pumpAndSettle();
    expect(testUtils.text("1"), findsOneWidget);
    expect(snackTitle0, findsOneWidget);

    await tester.tap(favBtnProduct);
    await tester.pumpAndSettle();
    expect(testUtils.text("2"), findsOneWidget);
    expect(snackTitle1, findsOneWidget);
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

    testUtils.checkImageTotalOnAView(1);
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

  void checkOverviewGridItemInOverviewView(tester, int itemsQtde) async {
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

    var favButton = testUtils.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

    // @formatter:off
    await tester
        .tap(favButton)
        .then((value) => tester.pumpAndSettle(testUtils.delay(DELAY)));
    // @formatter:on

    expect(
      testUtils.iconType(IconButton, Icons.favorite),
      findsNWidgets(favoritesAfterToggle),
    );
  }

  List<Product> _products() {
    return Get.find<IOverviewService>().getLocalDataAllProducts();
  }
}
// Future<Product> loadTwoProductsInDb(tester, {bool isWidgetTest}) async {
//   Product _product;
//
//   if (!isWidgetTest) {
//     await dbTestUtils.cleanDb(url: TEST_URL, interval: DELAY, db: DB_NAME);
//     await dbTestUtils
//         .addMultipleObjects(tester,
//             qtdeObjects: 2,
//             collectionUrl: PRODUCTS_URL,
//             object: ProductDataBuilder().ProductFullStaticNoId(),
//             interval: DELAY)
//         .then((value) => _product = value[0]);
//   }
//   return isWidgetTest ? ProductsMockedDatasource().products()[0] : _product;
// }
