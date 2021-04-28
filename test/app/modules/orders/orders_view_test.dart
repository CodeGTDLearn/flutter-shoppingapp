import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/orders.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../test_utils/test_utils.dart';
import 'orders_test_config.dart';

class OrdersViewTest {
  static void functional() {
    TestUtils _seek;
    var ovViewScaffGlobalKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
    var ordersDrawerOption = DRAWWER_ORDER_OPTION;

    setUp(() {
      OrdersTestConfig().bindingsBuilderMockedRepo();
      _seek = TestUtils();
    });

    tearDown(() => _seek = null);

    List<Product> _prods() {
      return ProductsMockedDatasource().products();
    }

    double _totalCart() {
      return Get.find<CartController>().getAmountCartItemsObs();
    }

    void checkOneOrderInOrdersPage({int widgetsLeastQtde}) {
      expect(_seek.text(ORDERS_TITLE_PAGE), findsOneWidget);
      expect(
        _seek.type(OrderCollapsableTile),
        widgetsLeastQtde == 0 ? findsNothing : findsWidgets,
      );
      expect(
        _seek.icon(ORDERS_ICON_COLLAPSE),
        widgetsLeastQtde == 0 ? findsNothing : findsWidgets,
      );
    }

    Future _openDrawwerAndClickOrdersDrawerOption(WidgetTester tester) async {
      ovViewScaffGlobalKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      await tester.tap(_seek.key(ordersDrawerOption));
      await tester.pump();
      await tester.pump(_seek.delay(3));
    }

    testWidgets('Opening OrderPage WITH an Order in DB', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      await _openDrawwerAndClickOrdersDrawerOption(tester);

      checkOneOrderInOrdersPage(widgetsLeastQtde: 1);
    });

    testWidgets('Opening OrderPage WITHOUT Any Order in DB', (tester) async {
      OrdersTestConfig().bindingsBuilderMockRepoEmptyDb();

      await tester.pumpWidget(AppDriver());

      await _openDrawwerAndClickOrdersDrawerOption(tester);

      expect(_seek.type(CircularProgressIndicator), findsOneWidget);
      expect(_seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);
      expect(_seek.text(ORDERS_TITLE_PAGE), findsOneWidget);

      await tester.pump();
      await tester.pump(_seek.delay(3));

      expect(_seek.text(ORDERS_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(NO_PRODUCTS_FOUND_IN_YET), findsOneWidget);
      expect(_seek.type(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());

      await _openDrawwerAndClickOrdersDrawerOption(tester);

      expect(_seek.text(ORDERS_TITLE_PAGE), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });

    testWidgets('Ordering from Cart Products - Button Order Now', (tester) async {
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
      expect(_seek.type(OverviewView), findsOneWidget);

      //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
      await tester.tap(cartButtonPage);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(_prods()[0].title), findsOneWidget);
      expect(_seek.type(CartView), findsOneWidget);

      //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
      expect(orderNowButton, findsOneWidget);
      await tester.tap(orderNowButton);
      await tester.pump(_seek.delay(1));
      expect(orderNowButton, findsNothing);
      expect(customCircProgrIndic, findsOneWidget);
      await tester.pump(_seek.delay(2));
      expect(_seek.type(OverviewView), findsOneWidget);

      //4) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
      await _openDrawwerAndClickOrdersDrawerOption(tester);
      checkOneOrderInOrdersPage(widgetsLeastQtde: 1);
      expect(_seek.type(OrdersView), findsOneWidget);

      //5) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(OrdersView), findsNothing);
      expect(_seek.type(OverviewView), findsOneWidget);
    });
  }
}
