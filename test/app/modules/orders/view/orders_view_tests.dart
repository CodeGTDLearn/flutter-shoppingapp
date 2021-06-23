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
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class OrdersViewTests {
  final TestUtils testUtils;
  final ViewTestUtils viewTestUtils;
  final testType;

  OrdersViewTests({this.testType, this.testUtils, this.viewTestUtils});

  Future OrderingFromCartView_TapButtonOrderNow(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    //A) ADDING ONE PRODUCT IN THE CART
    await tester.pumpAndSettle();
    expect(testUtils.type(OverviewView), findsOneWidget);
    await tester.tap(testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
    await tester.pumpAndSettle(testUtils.delay(delaySeconds));
    expect(testUtils.text("1"), findsOneWidget);

    //B) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(testUtils.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(delaySeconds));
    expect(testUtils.type(CartView), findsOneWidget);

    //C) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    await tester.tap(testUtils.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
    await tester.pump(testUtils.delay(delaySeconds));
    expect(testUtils.key(CART_PAGE_ORDERSNOW_BUTTON_KEY), findsNothing);
    expect(testUtils.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    await tester.pump(testUtils.delay(delaySeconds));
    expect(testUtils.type(OverviewView), findsOneWidget);

    //D) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      clickedKeyOption: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OrdersView,
      widgetType: OrderCollapsableTile,
      widgetQtde: 1,
    );

    //E) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
    await viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      triggerElement: BackButton,
    );
  }

  Future OpenOrderView_NoOrderInDB(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      clickedKeyOption: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(testUtils.type(OrdersView), findsOneWidget);
    expect(testUtils.type(CircularProgressIndicator), findsNothing);
    expect(testUtils.text(NO_ORDERS_FOUND_YET), findsOneWidget);

    await viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      triggerElement: BackButton,
    );
  }

  Future OpenOrderView_TapBackButton(
    WidgetTester tester,
    int delaySeconds, {
    Type from,
    Type to,
  }) async {
    await viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      triggerElement: BackButton,
    );
  }
}
