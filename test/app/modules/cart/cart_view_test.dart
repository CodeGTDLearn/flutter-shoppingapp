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
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../config/cart_test_config.dart';
import '../../../utils/test_utils.dart';

class CartViewTests {
  static void functional() {
    TestUtils _seek;

    setUp(() {
      CartTestConfig().bindingsBuilder();
      _seek = TestUtils();
    });

    tearDown(() => _seek = null);

    void _isInstancesRegistred() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);
    }

    List<Product> _prods() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    double totalCart() {
      return Get.find<CartController>().getAmountCartItemsObs();
    }

    testWidgets('Adding products + Check Appbar CartIcon Qtde', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_seek.text("0"), findsOneWidget);

      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);

      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("2"), findsOneWidget);
    });

    testWidgets('Adding a product + Check product in CartPage', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartButtonPage = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING A PRODUCT IN THE CART
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK 'PRODUCT' THE CART-PAGE
      await tester.tap(cartButtonPage);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(_prods()[0].title), findsOneWidget);
      expect(_seek.text('x1'), findsOneWidget);
    });

    testWidgets('Adding a product + Check Snackbar Info', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

      var snackbarInfo = '${_prods()[0].title}$ITEM_CART_ADDED_IN_THE_SHOPCART';

      //1) ADDING A PRODUCT IN THE CART
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(2));
      expect(_seek.type(SnackBar), findsOneWidget);
      expect(_seek.text(snackbarInfo), findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK CART-PAGE
      await tester.tap(_seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);

      //3) CLICKING BACKBUTTON
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_seek.type(SnackBar), findsNothing);
      expect(_seek.text(snackbarInfo), findsNothing);
    });

    testWidgets('Denying FIRST product Dismissing', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartItemTitleProduct1 = _seek.text(_prods()[0].title.toString());
      var keyCartItemProduct1 = _seek.key('${_prods()[0].id}');
      var typeCardCartItem = _seek.type(DismisCartItem);
      var cartPageButton = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var cartPageTitle = _seek.text(CART_TITLE_PAGE);

      //1) ADDING A PRODUCT IN THE CART
      await tester.tap(cartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(cartItemTitleProduct1, findsOneWidget);

      //2) CLICKING CART-PAGE-BUTTON AND CHECK THE CART
      await tester.tap(cartPageButton);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(cartPageTitle, findsOneWidget);
      expect(typeCardCartItem, findsNWidgets(1));

      //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
      await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(AlertDialog), findsOneWidget);
      expect(_seek.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_seek.text(NO));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(typeCardCartItem, findsNWidgets(1));
    });

    testWidgets('Dismissing FIRST added product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartItemTitleProduct1 = _seek.text(_prods()[0].title.toString());
      var keyCartItemProduct1 = _seek.key('${_prods()[0].id}');
      var typeCardCartItem = _seek.type(DismisCartItem);
      var cartPageButton = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var cartPageTitle = _seek.text(CART_TITLE_PAGE);

      //1) ADDING A PRODUCT IN THE CART
      await tester.tap(cartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(cartItemTitleProduct1, findsOneWidget);

      //2) CLICKING CART-PAGE-BUTTON AND CHECK THE CART
      await tester.tap(cartPageButton);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(cartPageTitle, findsOneWidget);
      expect(typeCardCartItem, findsNWidgets(1));

      //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
      await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(AlertDialog), findsOneWidget);
      expect(_seek.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_seek.text(YES));
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(typeCardCartItem, findsNWidgets(0));
    });

    testWidgets('Dismissing SECOND/LAST added product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartIconProduct2 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
      var productTitle1 = _seek.text(_prods()[0].title.toString());
      var productTitle2 = _seek.text(_prods()[1].title.toString());
      var productPrice1 = _prods()[0].price;
      var productPrice2 = _prods()[1].price;
      var keyCartItemProduct1 = _seek.key('${_prods()[0].id}');
      var keyCartItemProduct2 = _seek.key('${_prods()[1].id}');
      var typeDismisCartItem = _seek.type(DismisCartItem);
      var cartPageButton = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var cartPageTitle = _seek.text(CART_TITLE_PAGE);
      var overviewPageTitle = _seek.text(OVERVIEW_TITLE_PAGE_ALL);

      //1) ADDING A PRODUCT IN THE CART
      expect(overviewPageTitle, findsOneWidget);
      await tester.tap(cartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(productTitle1, findsOneWidget);
      await tester.tap(cartIconProduct2);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("2"), findsOneWidget);
      expect(productTitle2, findsOneWidget);

      //2) CLICKING CART-PAGE-BUTTON AND CHECK CART-AMOUNT + CART-ITEMS
      await tester.tap(cartPageButton);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(cartPageTitle, findsOneWidget);
      expect(typeDismisCartItem, findsNWidgets(2));
      expect(_seek.text((productPrice1 + productPrice2).toString()), findsOneWidget);

      //3) DISMISSING(LEFT DRAGGING TO DELETE) THE PRODUCT 01
      await tester.drag(keyCartItemProduct1, Offset(-500.0, 0.0));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(AlertDialog), findsOneWidget);
      expect(_seek.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_seek.text(YES));
      await tester.pumpAndSettle(_seek.delay(1));

      expect(typeDismisCartItem, findsNWidgets(1));
      expect(_seek.text(productPrice2.toString()), findsOneWidget);

      //4) DISMISSING(LEFT DRAGGING) THE PRODUCT 02
      await tester.drag(keyCartItemProduct2, Offset(-500.0, 0.0));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(AlertDialog), findsOneWidget);
      expect(_seek.text(CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM), findsOneWidget);
      await tester.tap(_seek.text(YES));
      await tester.pumpAndSettle(_seek.delay(1));

      expect(typeDismisCartItem, findsNWidgets(0));

      //5) CHECKING 'NO ELEMENTS IN THE CART ANYMORE'
      expect(cartPageTitle, findsNothing);
      expect(overviewPageTitle, findsOneWidget);
    });

    testWidgets('No products in Cart, No access to Cart Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      //1) ADDING A PRODUCT IN THE CART
      expect(_seek.text("0"), findsOneWidget);
      await tester.pumpAndSettle(_seek.delay(2));

      //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE
      await tester.tap(_seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsNothing);
    });

    testWidgets('Acessing Cart Page + Testing two product added', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var CartIconProduct2 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
      var snackbartext1 = _seek.text(_prods()[0].title.toString());
      var snackbartext2 = _seek.text(_prods()[1].title.toString());
      var cartButtonPage = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING TWO PRODUCT IN THE CART
      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(CartIconProduct2);
      await tester.tap(CartIconProduct2);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("4"), findsOneWidget);
      expect(snackbartext2, findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(_prods()[0].title), findsOneWidget);
      expect(_seek.text('\$${_prods()[0].price}'), findsOneWidget);
      expect(_seek.text(_prods()[1].title), findsOneWidget);
      expect(_seek.text('\$${_prods()[1].price}'), findsOneWidget);
      expect(_seek.text('x2'), findsNWidgets(2));
    });

    testWidgets('Checking Amount Cart', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var cartController = Get.find<CartController>();
      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _seek.text(_prods()[1].title.toString());
      var cartButtonPage = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING TWO PRODUCT IN THE CART
      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);

      //2) CLICKING CART-BUTTON AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);
      expect(
          _seek.text(cartController.getAmountCartItemsObs().toString()), findsOneWidget);
    });

    testWidgets('Ordering Cart Products - Order Now button', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _seek.text(_prods()[1].title.toString());
      var cartButtonPage = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var orderNowButton = _seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY);
      var customCircProgrIndic = _seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

      //1) ADDING ONE PRODUCT IN THE CART
      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);

      //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(_prods()[0].title), findsOneWidget);

      //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
      expect(totalCart() > 0, isTrue);
      expect(orderNowButton, findsOneWidget);
      await tester.tap(orderNowButton);
      await tester.pump(_seek.delay(1));
      expect(orderNowButton, findsNothing);
      expect(customCircProgrIndic, findsOneWidget);
      expect(totalCart() == 0, isTrue);
      await tester.pump(_seek.delay(2));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });

    testWidgets('Clearing Cart Products - ClearCart IconButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _seek.text(_prods()[1].title.toString());
      var cartButtonPage = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);
      var clearCartButton = _seek.key(CART_PAGE_CLEARCART_BUTTON_KEY);
      var customCircProgrIndic = _seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

      //1) ADDING ONE PRODUCT IN THE CART
      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);

      //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(_prods()[0].title), findsOneWidget);

      //3) CLICKING CLEAR-CART-BUTTON AND GO BACK TO THE PREVIOUS PAGE
      expect(totalCart() > 0, isTrue);
      expect(clearCartButton, findsOneWidget);
      await tester.tap(clearCartButton);
      await tester.pump(_seek.delay(1));
      expect(customCircProgrIndic, findsOneWidget);
      await tester.pump(_seek.delay(1));
      expect(totalCart() == 0, isTrue);
      await tester.pump(_seek.delay(2));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var CartIconProduct1 = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var cartButtonPage = _seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY);

      //1) ADDING A PRODUCT IN THE CART
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      await tester.tap(CartIconProduct1);
      await tester.pumpAndSettle(_seek.delay(1));

      //2) CLICKING CART-BUTTON AND CHECK THE CART-PAGE+BACKBUTTON
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);

      //3) CLICKING BACKBUTTON
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });
  }
}
