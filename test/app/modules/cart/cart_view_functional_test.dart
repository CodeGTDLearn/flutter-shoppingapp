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
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../config/bindings/cart_test_config.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/test_methods_utils.dart';

class CartViewFunctionalTests {
  static void functional() {
    late FinderUtils _finder;
    var _testMethodsUtils = Get.put(TestMethodsUtils());

    setUp(() {
      CartTestConfig().bindingsBuilder();
      _finder = Get.put(FinderUtils());
    });

    // void _isInstancesRegistred() {
    //   expect(Get.isRegistered<IOverviewRepo>(), isTrue);
    //   expect(Get.isRegistered<IOverviewService>(), isTrue);
    //   expect(Get.isRegistered<OverviewController>(), isTrue);
    //   expect(Get.isRegistered<CartController>(), isTrue);
    // }

    List<Product> _prods() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    double totalCart() {
      return Get.find<CartController>().getAmountCartItemsObs();
    }

    testWidgets('Adding products + Check Appbar CartIcon Qtde', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_finder.text("0"), findsOneWidget);

      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);

      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("2"), findsOneWidget);
    });

    testWidgets('Adding a product + Check product in CartPage', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartButtonPage = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING A PRODUCT IN THE CART
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_finder.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK 'PRODUCT' THE CART-PAGE
      await tester.tap(cartButtonPage);
      await tester.pump();
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_finder.text(_prods()[0].title), findsOneWidget);
      expect(_finder.text('x1'), findsOneWidget);
    });

    testWidgets('Adding a product + Check Snackbar Info', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

      var snackbarInfo = '${_prods()[0].title}$ITEM_CART_ADDED_IN_THE_SHOPCART';

      //1) ADDING A PRODUCT IN THE CART
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(2));
      expect(_finder.type(SnackBar), findsOneWidget);
      expect(_finder.text(snackbarInfo), findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK CART-PAGE
      await tester.tap(_finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);

      //3) CLICKING BACKBUTTON
      await tester.tap(_finder.type(BackButton));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_finder.type(SnackBar), findsNothing);
      expect(_finder.text(snackbarInfo), findsNothing);
    });

    testWidgets('Denying FIRST product Dismissing', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartItemTitleProduct1 = _finder.text(_prods()[0].title.toString());
      var keyCartItemProduct1 = _finder.key('${_prods()[0].id}');
      var typeCardCartItem = _finder.type(DismisCartItem);
      var cartPageButton = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var cartPageTitle = _finder.text(CART_TITLE_PAGE);

      //1) ADDING A PRODUCT IN THE CART
      await tester.tap(cartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);
      expect(cartItemTitleProduct1, findsOneWidget);

      //2) CLICKING CART-PAGE-BUTTON AND CHECK THE CART
      await tester.tap(cartPageButton);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(cartPageTitle, findsOneWidget);
      expect(typeCardCartItem, findsNWidgets(1));

      //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
      await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.type(AlertDialog), findsOneWidget);
      expect(_finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_finder.text(NO));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(typeCardCartItem, findsNWidgets(1));
    });

    testWidgets('Dismissing FIRST added product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartItemTitleProduct1 = _finder.text(_prods()[0].title.toString());
      var keyCartItemProduct1 = _finder.key('${_prods()[0].id}');
      var typeCardCartItem = _finder.type(DismisCartItem);
      var cartPageButton = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var cartPageTitle = _finder.text(CART_TITLE_PAGE);

      //1) ADDING A PRODUCT IN THE CART
      await tester.tap(cartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);
      expect(cartItemTitleProduct1, findsOneWidget);

      //2) CLICKING CART-PAGE-BUTTON AND CHECK THE CART
      await tester.tap(cartPageButton);
      await tester.pump();
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(cartPageTitle, findsOneWidget);
      expect(typeCardCartItem, findsNWidgets(1));

      //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
      await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
      await tester.pump();
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.type(AlertDialog), findsOneWidget);
      expect(_finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_finder.text(YES));
      await tester.pump();
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(typeCardCartItem, findsNWidgets(0));
    });

    testWidgets('Dismissing SECOND/LAST added product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartIconProduct2 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
      var productTitle1 = _finder.text(_prods()[0].title.toString());
      var productTitle2 = _finder.text(_prods()[1].title.toString());
      var productPrice1 = _prods()[0].price;
      var productPrice2 = _prods()[1].price;
      var keyCartItemProduct1 = _finder.key('${_prods()[0].id}');
      var keyCartItemProduct2 = _finder.key('${_prods()[1].id}');
      var typeDismisCartItem = _finder.type(DismisCartItem);
      var cartPageButton = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var cartPageTitle = _finder.text(CART_TITLE_PAGE);
      var overviewPageTitle = _finder.text(OVERVIEW_TITLE_PAGE_ALL);

      //1) ADDING A PRODUCT IN THE CART
      expect(overviewPageTitle, findsOneWidget);
      await tester.tap(cartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);
      expect(productTitle1, findsOneWidget);
      await tester.tap(cartIconProduct2);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("2"), findsOneWidget);
      expect(productTitle2, findsOneWidget);

      //2) CLICKING CART-PAGE-BUTTON AND CHECK CART-AMOUNT + CART-ITEMS
      await tester.tap(cartPageButton);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(cartPageTitle, findsOneWidget);
      expect(typeDismisCartItem, findsNWidgets(2));
      expect(_finder.text((productPrice1 + productPrice2).toString()), findsOneWidget);

      //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
      await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.type(AlertDialog), findsOneWidget);
      expect(_finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_finder.text(YES));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));

      expect(typeDismisCartItem, findsNWidgets(1));
      expect(_finder.text(productPrice2.toString()), findsOneWidget);

      //4) DISMISSING(LEFT DRAGGING) THE PRODUCT 02
      await tester.drag(keyCartItemProduct2, Offset(-500.0, 0.0));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.type(AlertDialog), findsOneWidget);
      expect(_finder.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_finder.text(YES));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));

      expect(typeDismisCartItem, findsNWidgets(0));

      //5) CHECKING 'NO ELEMENTS IN THE CART ANYMORE'
      expect(cartPageTitle, findsNothing);
      expect(overviewPageTitle, findsOneWidget);
    });

    testWidgets('No products in Cart, No access to Cart Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      //1) ADDING A PRODUCT IN THE CART
      expect(_finder.text("0"), findsOneWidget);
      await tester.pumpAndSettle(_testMethodsUtils.delay(2));

      //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE
      await tester.tap(_finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsNothing);
    });

    testWidgets('Acessing Cart Page + Testing two product added', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var CartIconProduct2 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
      var snackbartext1 = _finder.text(_prods()[0].title.toString());
      var snackbartext2 = _finder.text(_prods()[1].title.toString());
      var cartButtonPage = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING TWO PRODUCT IN THE CART
      expect(_finder.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(CartIconProduct2);
      await tester.tap(CartIconProduct2);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("4"), findsOneWidget);
      expect(snackbartext2, findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_finder.text(_prods()[0].title), findsOneWidget);
      expect(_finder.text('\$${_prods()[0].price}'), findsOneWidget);
      expect(_finder.text(_prods()[1].title), findsOneWidget);
      expect(_finder.text('\$${_prods()[1].price}'), findsOneWidget);
      expect(_finder.text('x2'), findsNWidgets(2));
    });

    testWidgets('Checking Amount Cart', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartController = Get.find<CartController>();
      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _finder.text(_prods()[1].title.toString());
      var cartButtonPage = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING TWO PRODUCT IN THE CART
      expect(_finder.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_finder.text(cartController.getAmountCartItemsObs().toString()),
          findsOneWidget);
    });

    testWidgets('Ordering Cart Products - Order Now button', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _finder.text(_prods()[1].title.toString());
      var cartButtonPage = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var orderNowButton = _finder.key(CART_PAGE_ORDERSNOW_BUTTON_KEY);
      var customCircProgrIndic = _finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

      //1) ADDING ONE PRODUCT IN THE CART
      expect(_finder.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);

      //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_finder.text(_prods()[0].title), findsOneWidget);

      //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
      expect(totalCart() > 0, isTrue);
      expect(orderNowButton, findsOneWidget);
      await tester.tap(orderNowButton);
      await tester.pump(_testMethodsUtils.delay(1));
      expect(orderNowButton, findsNothing);
      expect(customCircProgrIndic, findsOneWidget);
      expect(totalCart() == 0, isTrue);
      await tester.pump(_testMethodsUtils.delay(2));
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });

    testWidgets('Clearing Cart Products - ClearCart IconButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _finder.text(_prods()[1].title.toString());
      var cartButtonPage = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var clearCartButton = _finder.key(CART_PAGE_CLEARCART_BUTTON_KEY);
      var customCircProgrIndic = _finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

      //1) ADDING ONE PRODUCT IN THE CART
      expect(_finder.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);

      //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_finder.text(_prods()[0].title), findsOneWidget);

      //3) CLICKING CLEAR-CART-BUTTON AND GO BACK TO THE PREVIOUS PAGE
      expect(totalCart() > 0, isTrue);
      expect(clearCartButton, findsOneWidget);
      await tester.tap(clearCartButton);
      await tester.pump(_testMethodsUtils.delay(1));
      expect(customCircProgrIndic, findsOneWidget);
      await tester.pump(_testMethodsUtils.delay(1));
      expect(totalCart() == 0, isTrue);
      await tester.pump(_testMethodsUtils.delay(2));
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _finder.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartButtonPage = _finder.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING A PRODUCT IN THE CART
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));

      //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE+BACKBUTTON
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(CART_TITLE_PAGE), findsOneWidget);

      //3) CLICKING BACKBUTTON
      await tester.tap(_finder.type(BackButton));
      await tester.pumpAndSettle(_testMethodsUtils.delay(1));
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });
  }
}
