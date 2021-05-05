import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/orders.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';

class OrdersViewTests {

  Future Test_OrderingFromCartViewUsingTheButtonOrderNow(
      WidgetTester tester, TestUtils _seek) async {
    var products = ProductsMockedDatasource().products();

//todo: adicionar products using _openInventoryAddEditView/_AddingAndSavingOneProduct
    // para testar corretamente o firebase

    await tester.pumpAndSettle();

    //1) ADDING ONE PRODUCT IN THE CART
    await tester.pumpAndSettle();
    expect(_seek.type(OverviewView), findsOneWidget);
    await tester.tap(_seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
    await tester.pumpAndSettle(_seek.delay(1));
    expect(_seek.text("1"), findsOneWidget);

    //2) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(_seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(_seek.delay(1));
    expect(_seek.type(CartView), findsOneWidget);
    expect(_seek.text(products[0].title), findsOneWidget);

    //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    await tester.tap(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
    await tester.pump(_seek.delay(1));
    expect(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY), findsNothing);
    expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    await tester.pump(_seek.delay(2));
    expect(_seek.type(OverviewView), findsOneWidget);

    //4) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
    await openDrawerAndClickOrdersOption(tester, _seek);
    expect(_seek.type(OrdersView), findsOneWidget);
    checkOneOrderInOrdersView(_seek, widgetsLeastQtde: 1);

    //5) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(1));
    expect(_seek.type(OverviewView), findsOneWidget);
  }

  Future openDrawerAndClickOrdersOption(WidgetTester tester, TestUtils seek) async {
    await tester.pumpAndSettle();
    OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(seek.delay(3));
    await tester.tap(seek.key(DRAWWER_ORDER_OPTION));
    await tester.pumpAndSettle();
    await tester.pump(seek.delay(3));
  }

  Future Test_PageBackButton(TestUtils _seek, WidgetTester tester) async {
    expect(_seek.type(OrdersView), findsOneWidget);
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(3));
    expect(_seek.type(OverviewView), findsOneWidget);
  }

  void checkOneOrderInOrdersView(TestUtils seek, {int widgetsLeastQtde}) {
    expect(seek.text(ORDERS_TITLE_PAGE), findsOneWidget);
    expect(
      seek.type(OrderCollapsableTile),
      widgetsLeastQtde == 0 ? findsNothing : findsWidgets,
    );
    expect(
      seek.icon(ORDERS_ICON_COLLAPSE),
      widgetsLeastQtde == 0 ? findsNothing : findsWidgets,
    );
  }
}
