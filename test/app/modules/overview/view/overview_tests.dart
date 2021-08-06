import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

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
    required this.testUtils,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.dbTestUtils,
  });

  Future addProduct_CheckShopCartIconAndSnackbar(
    tester, {
    required String addProductButtonKey,
    required String productTitle,
  }) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var firstProductCartIconKey = testUtils.key(addProductButtonKey);

    await tester.tap(firstProductCartIconKey);
    await tester.tap(firstProductCartIconKey);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text("2"), findsOneWidget);
    expect(testUtils.text(productTitle), findsWidgets);
  }

  Future addProduct_ClickUndoInSnackbar(
    tester, {
    required String addProductButtonKey,
    required String productTitle,
    required String snackbarUndoButtonKey,
  }) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(testUtils.key(addProductButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text("1"), findsOneWidget);
    expect(testUtils.text(productTitle), findsWidgets);
    await tester.tap(testUtils.key(snackbarUndoButtonKey));
    await tester.pump();
    expect(testUtils.text("0"), findsOneWidget);
  }

  Future tap_FavoritesFilter_NoFavoritesFound(tester) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    await tester.pump();
    var favoriteFilterOption = testUtils.key(OVERVIEW_FAVORITE_FILTER_FAV_KEY);

    if (isWidgetTest) {
      await tester.tap(testUtils.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\2'));
    }
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNothing);

    await tester.tap(testUtils.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY));
    await tester.pump(testUtils.delay(DELAY));

    await tester.ensureVisible(favoriteFilterOption);
    await tester.tap(favoriteFilterOption);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
  }

  Future tap_FavoriteFilterPopup(tester) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    var productFavoriteBtn = testUtils.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\1');
    var popup = testUtils.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
    var popupItemFav = testUtils.key(OVERVIEW_FAVORITE_FILTER_FAV_KEY);
    var popupItemAll = testUtils.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    if (!isWidgetTest) await tester.tap(productFavoriteBtn);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));

    await tester.tap(popup);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(popupItemFav);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(testUtils.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsOneWidget);
    expect(testUtils.type(OverviewGridItem), findsOneWidget);
    // expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));

    await tester.tap(popup);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(popupItemAll);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(testUtils.iconType(IconButton, Icons.favorite), findsNWidgets(1));
    expect(testUtils.type(OverviewGridItem), findsNWidgets(4));
  }

  Future close_FavoriteFilterPopup(tester) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

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

  Future add_SameProduct_3x_CheckingShopCartIcon(
    tester, {
    required List<Product> listProducts,
    required String addProductButtonKey,
  }) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    var addProductKey = testUtils.key(addProductButtonKey);
    var snackTitle = testUtils.text("${listProducts[0].title}$ITEMCART_ADDED");
    await tester.tap(addProductKey);
    await tester.tap(addProductKey);
    await tester.tap(addProductKey);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text("3"), findsOneWidget);
    expect(snackTitle, findsOneWidget);
  }

  Future add_4DifferentProducts_CheckingShopCartIcon(
    tester, {
    required String addOnlyTheFirstProductButtonKey,
  }) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    var cartIconProduct0 = testUtils.key(addOnlyTheFirstProductButtonKey);
    var cartIconProduct1 =
        testUtils.key(addOnlyTheFirstProductButtonKey.replaceFirst('0', '1'));
    var cartIconProduct2 =
        testUtils.key(addOnlyTheFirstProductButtonKey.replaceFirst('0', '2'));
    var cartIconProduct3 =
        testUtils.key(addOnlyTheFirstProductButtonKey.replaceFirst('0', '3'));

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

    await tester.tap(cartIconProduct0);
    await tester.pump();
    expect(testUtils.text("1"), findsOneWidget);

    await tester.tap(cartIconProduct1);
    await tester.pump();
    expect(testUtils.text("2"), findsOneWidget);

    await tester.tap(cartIconProduct2);
    await tester.pump();
    expect(testUtils.text("3"), findsOneWidget);

    await tester.tap(cartIconProduct3);
    await tester.pump();
    expect(testUtils.text("4"), findsOneWidget);
  }

  Future clickProductCheckDetailsImage(tester) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);
    await tester.pump();

    var keyProduct1 = testUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

    await tester.tap(keyProduct1);

    // check if the page has changed
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.text(_products()[0].title.toString()), findsOneWidget);

    testUtils.checkImageTotalInAView(1);
  }

  Future clickProductCheckDetailsText(tester) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);
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

  Future check_OverviewGridItemsInOverviewView(tester, {required int itemsQtde}) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsTypesQtdeInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: itemsQtde,
    );
  }

  void checkOverviewFavorites(tester, int itemsQtde) async {
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsTypesQtdeInAView(
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
    await uiTestUtils.testBootstrapRestartState(tester, isWidgetTest: isWidgetTest);

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
