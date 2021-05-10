import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/orders.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_add_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../test_utils/test_utils.dart';

class OrdersViewTests {
  final _seek = TestUtils();

  Future Test_OrderingFromCartViewUsingTheButtonOrderNow(WidgetTester tester) async {
    // await tester.pumpAndSettle();

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
    // expect(_seek.text(product.title), findsOneWidget);

    //3) CLICKING ORDER-NOW-BUTTON AND GO BACK TO THE PREVIOUS PAGE
    await tester.tap(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY));
    await tester.pump(_seek.delay(1));
    expect(_seek.key(CART_PAGE_ORDERSNOW_BUTTON_KEY), findsNothing);
    expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    await tester.pump(_seek.delay(2));
    expect(_seek.type(OverviewView), findsOneWidget);

    //4) OPEN ORDERS-DRAWER-OPTION AND CHECK THE ORDER DONE ABOVE
    await openDrawerAndClickAnOption(tester, keyOption: DRAWER_ORDER_OPTION_KEY);
    expect(_seek.type(OrdersView), findsOneWidget);
    checkOneOrderInOrdersView(widgetsMinimalQtde: 1);

    //5) PRESS BACK-BUTTON AND GOBACK TO OVERVIEW-PAGE
    // await tester.tap(_seek.type(BackButton));
    // await tester.pumpAndSettle(_seek.delay(1));
    // expect(_seek.type(OverviewView), findsOneWidget);
    await tapBackButtonView(tester, from: OrdersView, to: OverviewView);
  }

  Future Test_OrderViewTapBackButton(WidgetTester tester, {Type from, Type to}) async {
    await tapBackButtonView(
      tester,
      from: OrdersView,
      to: OverviewView,
    );
  }

  Future tapBackButtonView(WidgetTester tester, {Type from, Type to}) async {
    expect(_seek.type(from), findsOneWidget);
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(3));
    expect(_seek.type(to), findsOneWidget);
  }

  Future addOneProductInDB(tester, {bool testWithValidTexts}) async {
    var fakeTitle, fakePrice, fakeDesc, fakeImgUrl, invalidText;
    var _seek = Get.put(TestUtils(), tag: 'localTestUtilsInstance');

    // A) OPEN DRAWER
    await tester.pumpAndSettle();
    expect(_seek.type(OverviewView), findsOneWidget);
    OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(_seek.delay(3));

    // B) CLICK IN INVENTORY-DRAWER-OPTION
    await tester.tap(_seek.key(DRAWER_INVENTORY_OPTION_KEY));
    await tester.pumpAndSettle();
    await tester.pump(_seek.delay(3));
    expect(_seek.type(InventoryView), findsOneWidget);

    // C) CLICK IN INVENTORY-ADD-PRODUCT
    await tester.tap(_seek.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
    await tester.pumpAndSettle();
    await tester.pump(_seek.delay(3));
    expect(_seek.type(InventoryAddEditView), findsOneWidget);

    // D) GENERATE PRE-BUIT CONTENT + CLICK IN THE TEXT-FIELDS + ADD CONTENT
    invalidText = "d";
    fakeTitle = "Red Tomatoes";
    fakePrice = (99.99).toString();
    fakeDesc = "The best Red tomatoes ever. It is super red!";
    fakeImgUrl =
        "https://images.freeimages.com/images/large-previews/294/tomatoes-1326096.jpg";

    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);
    expect(_seek.text(INVENTORY_ADDEDIT_IMAGE_TITLE), findsOneWidget);

    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY),
      testWithValidTexts ? fakeTitle : invalidText,
    );
    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_PRICE_KEY),
      testWithValidTexts ? fakePrice : invalidText,
    );
    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY),
      testWithValidTexts ? fakeDesc : invalidText,
    );
    await tester.enterText(
      _seek.key(INVENTORY_ADDEDIT_FIELD_URL_KEY),
      testWithValidTexts ? fakeImgUrl : invalidText,
    );
    await tester.pumpAndSettle(_seek.delay(2));

    // E) CLICK IN SAVE-BUTTON + RETURN TO INVENTORY-VIEW
    await tester.tap(_seek.key(INVENTORY_ADDEDIT_SAVEBUTTON_KEY));
    await tester.pump();
    await tester.pump(_seek.delay(2));
    await tester.pumpAndSettle();
    expect(_seek.type(InventoryView), findsOneWidget);
    expect(_seek.type(InventoryItem), findsWidgets);

    // F) CLICK IN BACK-BUTTON + RETURN TO OVERVIEW-VIEW
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(3));
    expect(_seek.type(OverviewView), findsOneWidget);
    expect(_seek.type(OverviewGridItem), findsWidgets);

    Get.delete(tag: 'localTestUtilsInstance');
  }

  Future openDrawerAndClickAnOption(WidgetTester tester, {String keyOption}) async {
    await tester.pumpAndSettle();
    OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(_seek.delay(3));
    await tester.tap(_seek.key(keyOption));
    await tester.pumpAndSettle();
    await tester.pump(_seek.delay(3));
  }

  void checkOneOrderInOrdersView({int widgetsMinimalQtde}) {
    expect(_seek.type(OrdersView), findsOneWidget);
    expect(
      _seek.type(OrderCollapsableTile),
      widgetsMinimalQtde == 0 ? findsNothing : findsWidgets,
    );
    expect(
      _seek.icon(ORDERS_ICON_COLLAPSE),
      widgetsMinimalQtde == 0 ? findsNothing : findsWidgets,
    );
  }
}
