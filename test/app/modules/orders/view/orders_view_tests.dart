import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../test_utils/db_test_utils.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/ui_test_utils.dart';

class OrdersViewTests {
  final TestUtils testUtils;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;
  final isWidgetTest;

  OrdersViewTests({
    this.isWidgetTest,
    this.testUtils,
    this.uiTestUtils,
    this.dbTestUtils,
  });

  Future OrderingFromCartView_TapButtonOrderNow(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    if (isWidgetTest == false) {
      await dbTestUtils.addObject(
        tester,
        object: ProductDataBuilder().ProductFullStaticNoId(),
        delaySeconds: DELAY,
        collectionUrl: PRODUCTS_URL,
      );
    }

    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
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
    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OrdersView,
      widgetType: OrderCollapsableTile,
      widgetQtde: 1,
    );

    //E) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
    await uiTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      triggerWidget: BackButton,
    );
  }

  Future checkOrders_OrdersAbsence(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(testUtils.type(OrdersView), findsOneWidget);
    expect(testUtils.type(CircularProgressIndicator), findsNothing);
    expect(testUtils.text(NO_ORDERS_FOUND_YET), findsOneWidget);

    await uiTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      triggerWidget: BackButton,
    );
  }

  Future tapingBackButtonInOrdersView(
    WidgetTester tester,
    int delaySeconds, {
    Type from,
    Type to,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      optionKey: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await tester.pumpAndSettle();

    await uiTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      triggerWidget: BackButton,
    );
  }
}
