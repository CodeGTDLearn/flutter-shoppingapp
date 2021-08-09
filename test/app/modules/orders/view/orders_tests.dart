import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/progres_indicator.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class OrdersTests {
  final testUtils;
  final uiTestUtils;
  final dbTestUtils;
  final isWidgetTest;

  OrdersTests({
    required this.isWidgetTest,
    required this.testUtils,
    required this.uiTestUtils,
    required this.dbTestUtils,
  });

  Future<void> Ordering_InCartView_TapOrderNowButton(
    WidgetTester tester,
    int interval,
  ) async {
    await create_order_from_cartView(tester, interval);

    //D) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      interval: interval,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.checkWidgetsQuantityInAView(
      widgetView: OrdersView,
      widgetType: OrderCollapsableTile,
      widgetQtde: 1,
    );

    //E) PRESS BACK-BUTTON AND GO-BACK TO OVERVIEW-PAGE
    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future<void> create_order_from_cartView(tester, int interval) async {
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      await dbTestUtils.addObject(
        object: ProductDataBuilder().ProductWithoutId(),
        interval: DELAY,
        collectionUrl: PRODUCTS_URL,
      );
    }

    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    //A) ADDING ONE PRODUCT IN THE CART
    await tester.pumpAndSettle(testUtils.delay(interval));
    expect(testUtils.type(OverviewView), findsOneWidget);
    await tester.tap(testUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"));
    await tester.pumpAndSettle(testUtils.delay(interval));

    //B) CLICKING CART-BUTTON-PAGE AND CHECK THE AMOUNT CART
    await tester.tap(testUtils.key(OVERVIEW_PAGE_SHOPCART_APPBAR_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(interval));
    expect(testUtils.type(CartView), findsOneWidget);

    //C) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    await tester.tap(testUtils.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
    await tester.pump(testUtils.delay(interval));
    expect(testUtils.type(ProgresIndicator), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(interval));
    expect(testUtils.type(OverviewView), findsOneWidget);
  }

  Future<void> check_emptyOrderCollection(
    WidgetTester tester,
    int interval,
  ) async {
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
    }
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      interval: interval,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(testUtils.type(OrdersView), findsOneWidget);
    expect(testUtils.type(CircularProgressIndicator), findsNothing);
    expect(testUtils.text(NO_ORDERS_FOUND_YET), findsOneWidget);

    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future<void> tappingBackButtonInOrdersView(
    WidgetTester tester,
    int interval, {
    required Type from,
    required Type to,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await tester.pumpAndSettle();

    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: OrdersView,
      to: OverviewView,
      trigger: BackButton,
    );
  }
}
