import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class OrdersViewTests {
  final _seek = TestUtils();
  final _viewTestUtils = ViewTestUtils();

  Future OrderingFromCartView_TapButtonOrderNow(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    //A) ADDING ONE PRODUCT IN THE CART
    await tester.pumpAndSettle();
    expect(_seek.type(OverviewView), findsOneWidget);
    await tester.tap(_seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    expect(_seek.text("1"), findsOneWidget);

    //B) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(_seek.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    expect(_seek.type(CartView), findsOneWidget);

    //C) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    await tester.tap(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
    await tester.pump(_seek.delay(delaySeconds));
    expect(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY), findsNothing);
    expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    await tester.pump(_seek.delay(delaySeconds));
    expect(_seek.type(OverviewView), findsOneWidget);

    //D) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OrdersView,
      widgetElement: OrderCollapsableTile,
      widgetQtde: 1,
    );

    //E) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future OpenOrderView_NoOrderInDB(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(_seek.type(OrdersView), findsOneWidget);
    expect(_seek.type(CircularProgressIndicator), findsNothing);
    expect(_seek.text(NO_ORDERS_FOUND_YET), findsOneWidget);

    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future OpenOrderView_TapBackButton(
    WidgetTester tester,
    int delaySeconds, {
    Type from,
    Type to,
  }) async {
    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }
}
