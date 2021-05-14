import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_add_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class OrdersViewTests {
  final _seek = TestUtils();
  final _guiUtils = ViewTestUtils();

  Future AddOneProductInDB(
    WidgetTester tester,
    int delaySeconds, {
    bool validTexts,
  }) async {
    var invalidText;
    var _seek = Get.put(TestUtils(), tag: 'localTestUtilsInstance');

    // A) OPEN DRAWER
    // B) CLICK IN INVENTORY-DRAWER-OPTION
    await _guiUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY,
    );

    expect(_seek.type(InventoryView), findsOneWidget);

    // C) CLICK IN INVENTORY-ADD-PRODUCT-BUTTON
    await _guiUtils.tapButtonWithResult(
      tester,
      delaySeconds: delaySeconds,
      keyWidgetTrigger: INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY,
      typeWidgetResult: InventoryAddEditView,
    );

    // D) GENERATE PRE-BUIT CONTENT + CLICK IN THE TEXT-FIELDS + ADD CONTENT
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_IMAGE_TITLE), findsOneWidget);

    invalidText = "d";
    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY),
      validTexts ? "Red Tomatoes" : invalidText,
    );

    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_PRICE_KEY),
      validTexts ? (99.99).toString() : invalidText,
    );

    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY),
      validTexts ? "The best Red tomatoes ever. It is super red!" : invalidText,
    );

    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_URL_KEY),
      validTexts
          ? "https://images.freeimages.com/images/large-previews/294/tomatoes-1326096.jpg"
          : invalidText,
    );

    await tester.pumpAndSettle(_seek.delay(delaySeconds));

    // E) CLICK IN SAVE-BUTTON + RETURN TO INVENTORY-VIEW + CHECK INVENTORY-ITEM ADDED
    await _guiUtils.tapButtonWithResult(
      tester,
      delaySeconds: delaySeconds,
      keyWidgetTrigger: INVENTORY_ADDEDIT_SAVEBUTTON_KEY,
      typeWidgetResult: InventoryItem,
    );

    // F) CLICK IN BACK-BUTTON + RETURN FROM INVENTORY-VIEW TO OVERVIEW-VIEW
    await _guiUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      widgetTrigger: BackButton,
    );

    Get.delete(tag: 'localTestUtilsInstance');
  }

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
    await _guiUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY,
    );
    _guiUtils.checkWidgetsQtdeInOneView(
      widgetView: OrdersView,
      widgetElement: OrderCollapsableTile,
      widgetQtde: 1,
    );

    //E) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
    await _guiUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      widgetTrigger: BackButton,
    );
  }

  Future OpenOrderView_NoOrderInDB(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await _guiUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_ORDER_OPTION_KEY,
      scaffoldGlobalKey: OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY,
    );
    expect(_seek.type(OrdersView), findsOneWidget);
    expect(_seek.type(CircularProgressIndicator), findsNothing);
    expect(_seek.text(NO_ORDERS_FOUND_YET), findsOneWidget);

    await _guiUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      widgetTrigger: BackButton,
    );
  }

  Future OpenOrderView_TapBackButton(
    WidgetTester tester,
    int delaySeconds, {
    Type from,
    Type to,
  }) async {
    await _guiUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: OrdersView,
      to: OverviewView,
      widgetTrigger: BackButton,
    );
  }

  void cleanDb() {
    http.delete("$PRODUCTS_URL_HTTP").then((response) {
      print('1111111 ${response.statusCode}');
    });
    http.delete("$ORDERS_URL_HTTP").then((response) {
      print('22222 ${response.statusCode}');
    });
    http.delete("$CART_ITEM_URL_HTTP").then((response) {
      print('33333 ${response.statusCode}');
    });
  }
}
