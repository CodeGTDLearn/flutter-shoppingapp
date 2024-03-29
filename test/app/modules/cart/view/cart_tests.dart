import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/components/core_components_keys.dart';
import 'package:shopingapp/app/core/texts/core_labels.dart';
import 'package:shopingapp/app/core/texts/core_messages.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_keys.dart';
import 'package:shopingapp/app/modules/cart/core/cart_labels.dart';
import 'package:shopingapp/app/modules/cart/core/components/dismissible_cart_item.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
import '../../../../config/utils/finder_utils.dart';
import '../../../../config/utils/testdb_utils.dart';
import '../../../../config/utils/tests_utils.dart';
import '../../../../config/utils/ui_test_utils.dart';

class CartTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestDbUtils dbTestUtils;
  final TestsUtils testUtils;
  final _messages = Get.put(CoreMessages());
  final _words = Get.put(CoreLabels());
  final _labels = Get.put(CartLabels());
  final _keysInd = Get.put(CoreComponentsKeys());
  final _keysOv = Get.put(OverviewKeys());
  final _keysCart = Get.put(CartKeys());

  CartTests({
    required this.isWidgetTest,
    required this.finder,
    required this.uiTestUtils,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> test_page_backbutton(tester) async {
    await _startApp_OpenOverviewView(tester);

    await _addProduct_tappingOverviewItem_openShopCartView(
      tester,
      itemToAdd: "${_keysOv.k_ov_grd_crt_btn}\0",
    );

    expect(finder.type(CartView), findsOneWidget);
    await tester.tap(finder.type(BackButton));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> clear_cart_tap_clear_button(tester) async {
    await _startApp_OpenOverviewView(tester);

    await tester.tap(finder.key("${_keysOv.k_ov_grd_crt_btn}\0"));
    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(Get.find<CartController>().amountCartItemsObs.value > 0.0, isTrue);

    await _clearCart_quitCartView(tester, finder.key(_keysCart.k_crt_clearcart_btn()));

    expect(Get.find<CartController>().amountCartItemsObs.value == 0, isTrue);
    expect(finder.type(DismissibleCartItem), findsNothing);
    expect(finder.key(_keysInd.k_circ_prg_indic()), findsOneWidget);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> order_cartProducts_tap_orderNowButton(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var orderNowButton = finder.key(_keysCart.k_crt_ordnow_btn());
    var customCircProgrIndic = finder.key(_keysInd.k_circ_prg_indic());

    await _addProduct_tappingOverviewItem_openShopCartView(
      tester,
      itemToAdd: "${_keysOv.k_ov_grd_crt_btn}\0",
    );

    expect(finder.type(CartView), findsOneWidget);
    await _clearCart_quitCartView(tester, finder.key(_keysCart.k_crt_clearcart_btn()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await _addProduct_tappingOverviewItem_openShopCartView(
      tester,
      itemToAdd: "${_keysOv.k_ov_grd_crt_btn}\0",
    );
    expect(Get.find<CartController>().amountCartItemsObs.value > 0, isTrue);
    expect(orderNowButton, findsOneWidget);
    expect(customCircProgrIndic, findsNothing);
    expect(finder.type(DismissibleCartItem), findsOneWidget);

    await tester.tap(orderNowButton);
    await tester.pump(testUtils.delay(DELAY));

    expect(Get.find<CartController>().amountCartItemsObs.value == 0, isTrue);
    expect(orderNowButton, findsNothing);
    expect(customCircProgrIndic, findsOneWidget);
    expect(finder.type(DismissibleCartItem), findsNothing);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> check_amount_cart(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("${_keysOv.k_ov_grd_crt_btn}\0");

    await tester.tap(cartIconProduct0);
    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(
      finder.text(Get.find<CartController>().amountCartItemsObs.value.toStringAsFixed(2)),
      findsOneWidget,
    );
  }

  Future<void> open_cartpage_check2products(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("${_keysOv.k_ov_grd_crt_btn}\0");
    var cartIconProduct1 = finder.key("${_keysOv.k_ov_grd_crt_btn}\1");

    await tester.tap(cartIconProduct0);
    await tester.tap(cartIconProduct0);
    await tester.tap(cartIconProduct1);
    await tester.tap(cartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("4"), findsOneWidget);

    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(finder.text(_productsList[0].title), findsOneWidget);
    expect(finder.text(_productsList[1].title), findsOneWidget);
    expect(finder.text('x2'), findsNWidgets(2));
    expect(finder.type(DismissibleCartItem), findsNWidgets(2));
  }

  Future<void> emptycart_block_access_to_cartpage(tester) async {
    await _startApp_OpenOverviewView(tester);
    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(OverviewView), findsOneWidget);
  }

  Future<void> dismissing_all_added_products(
    WidgetTester tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var typeDismisCartItem = finder.type(DismissibleCartItem);

    expect(finder.type(OverviewView), findsOneWidget);
    await tester.tap(finder.key("${_keysOv.k_ov_grd_crt_btn}\0"));
    await tester.tap(finder.key("${_keysOv.k_ov_grd_crt_btn}\1"));

    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(typeDismisCartItem, findsNWidgets(2));

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.drag(finder.key('${_productsList[0].id}'), Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(_labels.titleDialogDismis()), findsOneWidget);
    await tester.tap(finder.text(_words.yes()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeDismisCartItem, findsOneWidget);

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.drag(finder.key('${_productsList[1].id}'), Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(_labels.titleDialogDismis()), findsOneWidget);
    await tester.tap(finder.text(_words.yes()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeDismisCartItem, findsNothing);
  }

  Future<void> dismissing_first_added_product(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("${_keysOv.k_ov_grd_crt_btn}\0");
    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var typeCardCartItem = finder.type(DismissibleCartItem);
    var cartPageButton = finder.key(_keysCart.k_shopcart_appbar_btn());
    await tester.tap(cartPageButton);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(typeCardCartItem, findsOneWidget);

    var keyCartItemProduct1 = finder.key('${_productsList[0].id}');
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(_labels.titleDialogDismis()), findsOneWidget);
    await tester.tap(finder.text(_words.yes()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeCardCartItem, findsNothing);
  }

  Future<void> denying_dismissing_cartitem(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("${_keysOv.k_ov_grd_crt_btn}\0");
    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    var typeCardCartItem = finder.type(DismissibleCartItem);
    var cartPageButton = finder.key(_keysCart.k_shopcart_appbar_btn());
    await tester.tap(cartPageButton);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(typeCardCartItem, findsOneWidget);

    var keyCartItemProduct1 = finder.key('${_productsList[0].id}');
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(_labels.titleDialogDismis()), findsOneWidget);
    await tester.tap(finder.text(_words.no()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(typeCardCartItem, findsOneWidget);
  }

  Future<void> add_product_check_snackbar(
    tester,
    List<dynamic> _productsList,
  ) async {
    await _startApp_OpenOverviewView(tester);

    var cartIconProduct0 = finder.key("${_keysOv.k_ov_grd_crt_btn}\0");
    var snackbarInfo = '${_productsList.elementAt(0).title}${_messages.item_cart_added}';

    await tester.tap(cartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(SnackBar), findsOneWidget);
    expect(finder.text(snackbarInfo), findsOneWidget);
  }

  Future<void> add_products_check_cartPage(
    tester, {
    required int qtdeProducts,
  }) async {
    await _startApp_OpenOverviewView(tester);

    var CartIconProduct0 = finder.key("${_keysOv.k_ov_grd_crt_btn}\0");

    for (var i = 0; i < qtdeProducts; i++) {
      await tester.tap(CartIconProduct0);
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(finder.text((i + 1).toString()), findsOneWidget);
    }

    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(finder.text('x$qtdeProducts'), findsOneWidget);
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
    await tester.tap(finder.key(_keysCart.k_shopcart_appbar_btn()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }
}