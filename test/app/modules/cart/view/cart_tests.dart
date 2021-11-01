import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/generic_words.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/cart.dart';
import 'package:shopingapp/app/modules/cart/components/dismissible_cart_item.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/tests_properties.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class CartTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestDbUtils dbTestUtils;
  final TestsUtils testUtils;

  CartTests({
    required this.isWidgetTest,
    required this.finder,
    required this.uiTestUtils,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> Testing_pageBackButton(tester) async {
    await _startApp_OpenOverviewView(tester);

    await _addProduct_tappingOverviewItem_openShopCartView(
      tester,
      itemToAdd: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
    );

    expect(finder.type(CartView), findsOneWidget);
    await tester.tap(finder.type(BackButton));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> ClearingCart_tappingClearButton(tester) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartButtonPage = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    var customCircProgrIndic = finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);
    var clearCartButton = finder.key(CART_PAGE_CLEARCART_BUTTON_KEY);

    await tester.tap(cartIconProduct0);
    await tester.tap(cartButtonPage);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(Get.find<CartController>().getAmountCartItemsObs() > 0.0, isTrue);

    await _clearCart_quitCartView(tester, clearCartButton);

    expect(Get.find<CartController>().getAmountCartItemsObs() == 0, isTrue);
    expect(finder.type(DismissibleCartItem), findsNothing);
    expect(customCircProgrIndic, findsOneWidget);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> Ordering_cartProducts_tappingOrderNowButton(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var orderNowButton = finder.key(CART_PAGE_ORDERSNOW_BUTTON_KEY);
    var customCircProgrIndic = finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

    await _addProduct_tappingOverviewItem_openShopCartView(
      tester,
      itemToAdd: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
    );

    expect(finder.type(CartView), findsOneWidget);
    await _clearCart_quitCartView(tester, finder.key(CART_PAGE_CLEARCART_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await _addProduct_tappingOverviewItem_openShopCartView(
      tester,
      itemToAdd: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
    );
    expect(Get.find<CartController>().getAmountCartItemsObs() > 0, isTrue);
    expect(orderNowButton, findsOneWidget);
    expect(customCircProgrIndic, findsNothing);
    expect(finder.type(DismissibleCartItem), findsOneWidget);

    await tester.tap(orderNowButton);
    await tester.pump(testUtils.delay(DELAY));

    expect(Get.find<CartController>().getAmountCartItemsObs() == 0, isTrue);
    expect(orderNowButton, findsNothing);
    expect(customCircProgrIndic, findsOneWidget);
    expect(finder.type(DismissibleCartItem), findsNothing);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> Check_amountCart(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

    await tester.tap(cartIconProduct0);
    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(
      finder.text(Get.find<CartController>().getAmountCartItemsObs().toStringAsFixed(2)),
      findsOneWidget,
    );
  }

  Future<void> Opening_cartPage_check2Products(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");

    await tester.tap(cartIconProduct0);
    await tester.tap(cartIconProduct0);
    await tester.tap(cartIconProduct1);
    await tester.tap(cartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("4"), findsOneWidget);

    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(finder.text(_productsList[0].title), findsOneWidget);
    expect(finder.text(_productsList[1].title), findsOneWidget);
    expect(finder.text('x2'), findsNWidgets(2));
    expect(finder.type(DismissibleCartItem), findsNWidgets(2));
  }

  Future<void> EmptyCart_blockAccessCartPage(tester) async {
    await _startApp_OpenOverviewView(tester);
    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> Dismissing_allAddedProducts(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var typeDismisCartItem = finder.type(DismissibleCartItem);

    expect(finder.type(OverviewView), findsOneWidget);
    await tester.tap(finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
    await tester.tap(finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1"));

    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(typeDismisCartItem, findsNWidgets(2));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.drag(finder.key('${_productsList[0].id}'), Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(YES));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeDismisCartItem, findsOneWidget);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.drag(finder.key('${_productsList[1].id}'), Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(YES));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeDismisCartItem, findsNothing);
  }

  Future<void> Dismissing_firstAddedProduct(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var typeCardCartItem = finder.type(DismissibleCartItem);
    var cartPageButton = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    await tester.tap(cartPageButton);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(typeCardCartItem, findsOneWidget);

    var keyCartItemProduct1 = finder.key('${_productsList[0].id}');
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(YES));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeCardCartItem, findsNothing);
  }

  Future<void> Denying_dismissingCartItem(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var typeCardCartItem = finder.type(DismissibleCartItem);
    var cartPageButton = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    await tester.tap(cartPageButton);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(typeCardCartItem, findsOneWidget);

    var keyCartItemProduct1 = finder.key('${_productsList[0].id}');
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(NO));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeCardCartItem, findsOneWidget);
  }

  Future<void> AddProduct_checkSnackbar(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var snackbarInfo = '${_productsList[0].title}$ITEM_CART_ADDED_IN_THE_SHOPCART';

    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(SnackBar), findsOneWidget);
    expect(finder.text(snackbarInfo), findsOneWidget);
  }

  Future<void> Check_2Products_inCartPage(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartButtonView = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    await tester.tap(cartButtonView);
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(finder.text(_productsList[0].title), findsOneWidget);
    expect(finder.text('x2'), findsOneWidget);
  }

  Future<void> Add2Products_checkAppbarCartIconQtde(tester) async {
    await _startApp_OpenOverviewView(tester);

    var CartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    await tester.tap(CartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("1"), findsOneWidget);

    await tester.tap(CartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("2"), findsOneWidget);
  }

  Future<void> _startApp_OpenOverviewView(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
    await tester.pump();
  }

  Future<void> _clearCart_quitCartView(tester, Finder clearCartButton) async {
    await tester.tap(clearCartButton);
    await tester.pump();
    await tester.pump(testUtils.delay(DELAY));
  }

  Future<void> _addProduct_tappingOverviewItem_openShopCartView(
    WidgetTester tester, {
    required String itemToAdd,
  }) async {
    await tester.tap(finder.key(itemToAdd));
    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }
}
