import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/generic_words.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/cart.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/cart/components/dismis_cart_item.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/tests_properties.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/test_methods_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class CartTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;
  final TestMethodsUtils testUtils;

  CartTests({
    required this.isWidgetTest,
    required this.finder,
    required this.uiTestUtils,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> TestingPageBackButton(WidgetTester tester) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var CartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartButtonPage = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

    //1) ADDING A PRODUCT IN THE CART
    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    await tester.tap(CartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));

    //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE+BACKBUTTON
    await tester.tap(cartButtonPage);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsOneWidget);

    //3) CLICKING BACKBUTTON
    await tester.tap(finder.type(BackButton));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
  }

  Future<void> ClearCartProductsClearButton(
      WidgetTester tester, List<Product> _prods(), double totalCart()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var CartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var snackbartext1 = finder.text(_prods()[1].title.toString());
    var cartButtonPage = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    var clearCartButton = finder.key(CART_PAGE_CLEARCART_BUTTON_KEY);
    var customCircProgrIndic = finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

    //1) ADDING ONE PRODUCT IN THE CART
    expect(finder.text("0"), findsOneWidget);
    await tester.tap(CartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("1"), findsOneWidget);
    expect(snackbartext1, findsOneWidget);

    //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(cartButtonPage);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsOneWidget);
    expect(finder.text(_prods()[0].title), findsOneWidget);

    //3) CLICKING CLEAR-CART-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    expect(totalCart() > 0, isTrue);
    expect(clearCartButton, findsOneWidget);
    await tester.tap(clearCartButton);
    await tester.pump(testUtils.delay(1));
    expect(customCircProgrIndic, findsOneWidget);
    await tester.pump(testUtils.delay(1));
    expect(totalCart() == 0, isTrue);
    await tester.pump(testUtils.delay(2));
    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
  }

  Future<void> OrderCartProductsOrderNowButton(
      WidgetTester tester, List<Product> _prods(), double totalCart()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var CartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var snackbartext1 = finder.text(_prods()[1].title.toString());
    var cartButtonPage = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    var orderNowButton = finder.key(CART_PAGE_ORDERSNOW_BUTTON_KEY);
    var customCircProgrIndic = finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

    //1) ADDING ONE PRODUCT IN THE CART
    expect(finder.text("0"), findsOneWidget);
    await tester.tap(CartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("1"), findsOneWidget);
    expect(snackbartext1, findsOneWidget);

    //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(cartButtonPage);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsOneWidget);
    expect(finder.text(_prods()[0].title), findsOneWidget);

    //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    expect(totalCart() > 0, isTrue);
    expect(orderNowButton, findsOneWidget);
    await tester.tap(orderNowButton);
    await tester.pump(testUtils.delay(1));
    expect(orderNowButton, findsNothing);
    expect(customCircProgrIndic, findsOneWidget);
    expect(totalCart() == 0, isTrue);
    await tester.pump(testUtils.delay(2));
    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
  }

  Future<void> CheckAmountCart(WidgetTester tester, List<Product> _prods()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var cartController = Get.find<CartController>();
    var CartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var snackbartext1 = finder.text(_prods()[1].title.toString());
    var cartButtonPage = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

    //1) ADDING TWO PRODUCT IN THE CART
    expect(finder.text("0"), findsOneWidget);
    await tester.tap(CartIconProduct1);
    await tester.tap(CartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("2"), findsOneWidget);
    expect(snackbartext1, findsOneWidget);

    //2) CLICKING CART-BUTTON AND CHECK THE AMOUNT CART
    await tester.tap(cartButtonPage);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsOneWidget);
    expect(
        finder.text(cartController.getAmountCartItemsObs().toString()), findsOneWidget);
  }

  Future<void> AccessingCartPageTestingTwoAddedProducts(
      WidgetTester tester, List<Product> _prods()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var CartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var CartIconProduct2 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
    var snackbartext1 = finder.text(_prods()[0].title.toString());
    var snackbartext2 = finder.text(_prods()[1].title.toString());
    var cartButtonPage = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

    //1) ADDING TWO PRODUCT IN THE CART
    expect(finder.text("0"), findsOneWidget);
    await tester.tap(CartIconProduct1);
    await tester.tap(CartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("2"), findsOneWidget);
    expect(snackbartext1, findsOneWidget);
    await tester.tap(CartIconProduct2);
    await tester.tap(CartIconProduct2);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("4"), findsOneWidget);
    expect(snackbartext2, findsOneWidget);

    //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE
    await tester.tap(cartButtonPage);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsOneWidget);
    expect(finder.text(_prods()[0].title), findsOneWidget);
    expect(finder.text('\$${_prods()[0].price}'), findsOneWidget);
    expect(finder.text(_prods()[1].title), findsOneWidget);
    expect(finder.text('\$${_prods()[1].price}'), findsOneWidget);
    expect(finder.text('x2'), findsNWidgets(2));
  }

  Future<void> NoProductsInTheCartNoAccessCartPage(WidgetTester tester) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    //1) ADDING A PRODUCT IN THE CART
    expect(finder.text("0"), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(2));

    //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE
    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsNothing);
  }

  Future<void> DismissingSecondLastAddedProduct(
      WidgetTester tester, List<Product> _prods()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var cartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartIconProduct2 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
    var productTitle1 = finder.text(_prods()[0].title.toString());
    var productTitle2 = finder.text(_prods()[1].title.toString());
    var productPrice1 = _prods()[0].price;
    var productPrice2 = _prods()[1].price;
    var keyCartItemProduct1 = finder.key('${_prods()[0].id}');
    var keyCartItemProduct2 = finder.key('${_prods()[1].id}');
    var typeDismisCartItem = finder.type(DismisCartItem);
    var cartPageButton = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    var cartPageTitle = finder.text(CART_TITLE_PAGE);
    var overviewPageTitle = finder.text(OVERVIEW_TITLE_PAGE_ALL);

    //1) ADDING A PRODUCT IN THE CART
    expect(overviewPageTitle, findsOneWidget);
    await tester.tap(cartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("1"), findsOneWidget);
    expect(productTitle1, findsOneWidget);
    await tester.tap(cartIconProduct2);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("2"), findsOneWidget);
    expect(productTitle2, findsOneWidget);

    //2) CLICKING CART-PAGE-BUTTON AND CHECK CART-AMOUNT + CART-ITEMS
    await tester.tap(cartPageButton);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(cartPageTitle, findsOneWidget);
    expect(typeDismisCartItem, findsNWidgets(2));
    expect(finder.text((productPrice1 + productPrice2).toString()), findsOneWidget);

    //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(YES));
    await tester.pumpAndSettle(testUtils.delay(1));

    expect(typeDismisCartItem, findsNWidgets(1));
    expect(finder.text(productPrice2.toString()), findsOneWidget);

    //4) DISMISSING(LEFT DRAGGING) THE PRODUCT 02
    await tester.drag(keyCartItemProduct2, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(YES));
    await tester.pumpAndSettle(testUtils.delay(1));

    expect(typeDismisCartItem, findsNWidgets(0));

    //5) CHECKING 'NO ELEMENTS IN THE CART ANYMORE'
    expect(cartPageTitle, findsNothing);
    expect(overviewPageTitle, findsOneWidget);
  }

  Future<void> DismissingFirstAddedProduct(
      WidgetTester tester, List<Product> _prods()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var cartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartItemTitleProduct1 = finder.text(_prods()[0].title.toString());
    var keyCartItemProduct1 = finder.key('${_prods()[0].id}');
    var typeCardCartItem = finder.type(DismisCartItem);
    var cartPageButton = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    var cartPageTitle = finder.text(CART_TITLE_PAGE);

    //1) ADDING A PRODUCT IN THE CART
    await tester.tap(cartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("1"), findsOneWidget);
    expect(cartItemTitleProduct1, findsOneWidget);

    //2) CLICKING CART-PAGE-BUTTON AND CHECK THE CART
    await tester.tap(cartPageButton);
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(cartPageTitle, findsOneWidget);
    expect(typeCardCartItem, findsNWidgets(1));

    //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(YES));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(typeCardCartItem, findsNWidgets(0));
  }

  Future<void> DenyingFirstProductDismissing(
      WidgetTester tester, List<Product> _prods()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var cartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartItemTitleProduct1 = finder.text(_prods()[0].title.toString());
    var keyCartItemProduct1 = finder.key('${_prods()[0].id}');
    var typeCardCartItem = finder.type(DismisCartItem);
    var cartPageButton = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
    var cartPageTitle = finder.text(CART_TITLE_PAGE);

    //1) ADDING A PRODUCT IN THE CART
    await tester.tap(cartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text("1"), findsOneWidget);
    expect(cartItemTitleProduct1, findsOneWidget);

    //2) CLICKING CART-PAGE-BUTTON AND CHECK THE CART
    await tester.tap(cartPageButton);
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(cartPageTitle, findsOneWidget);
    expect(typeCardCartItem, findsNWidgets(1));

    //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
    await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.type(AlertDialog), findsOneWidget);
    expect(finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
    await tester.tap(finder.text(NO));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(typeCardCartItem, findsNWidgets(1));
  }

  Future<void> AddProductCheckSnackbarInfo(
      WidgetTester tester, List<Product> _prods()) async {
    await tester.pumpWidget(AppDriver());
    await tester.pump();

    var CartIconProduct1 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

    var snackbarInfo = '${_prods()[0].title}$ITEM_CART_ADDED_IN_THE_SHOPCART';

    //1) ADDING A PRODUCT IN THE CART
    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    await tester.tap(CartIconProduct1);
    await tester.pumpAndSettle(testUtils.delay(2));
    expect(finder.type(SnackBar), findsOneWidget);
    expect(finder.text(snackbarInfo), findsOneWidget);

    //2) CLICKING CART-BUTTON AND CHECK CART-PAGE
    await tester.tap(finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(CART_TITLE_PAGE), findsOneWidget);

    //3) CLICKING BACKBUTTON
    await tester.tap(finder.type(BackButton));
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    expect(finder.type(SnackBar), findsNothing);
    expect(finder.text(snackbarInfo), findsNothing);
  }

  Future<void> AddProductCheckProductInCartPage(
    WidgetTester tester,
    List<Product> _prods,
  ) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var CartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
    var cartButtonView = finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

    //1) ADDING A PRODUCT IN THE CART
    expect(finder.type(OverviewView), findsOneWidget);
    await tester.pump();

    await tester.tap(CartIconProduct0);
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("1"), findsOneWidget);

    //2) CLICKING CART-BUTTON AND CHECK 'PRODUCT' THE CART-PAGE
    await tester.tap(cartButtonView);
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(CartView), findsOneWidget);
    expect(finder.text(_prods[0].title), findsOneWidget);
    expect(finder.text('x1'), findsOneWidget);
  }

  Future<void> Add2Products_checkAppbarCartIconQtde(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var CartIconProduct0 = finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

    await tester.pump();
    expect(finder.type(OverviewView), findsOneWidget);
    await tester.pump();

    await tester.tap(CartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("1"), findsOneWidget);

    await tester.tap(CartIconProduct0);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text("2"), findsOneWidget);
  }
}
