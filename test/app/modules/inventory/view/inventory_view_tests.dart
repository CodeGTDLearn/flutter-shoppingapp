import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_add_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../app_tests_config.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class InventoryViewTests {
  final _seek = Get.put(TestUtils());
  final _viewTestUtils = Get.put(ViewTestUtils());

  // final _prods = ProductsMockedDatasource().products();

  Future tapingBackButtonInInventoryView(tester) async {
    await _viewTestUtils.navigationBetweenViews(
      tester,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
      delaySeconds: DELAY,
    );
  }

  Future checkInventoryProductsAbsence(
    WidgetTester tester,
    int delaySeconds,
  ) async {
    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetType: InventoryItem,
    );

    expect(_seek.text(NO_INVENTORY_PRODUCTS_FOUND_YET), findsOneWidget);

    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future refreshingInventoryView(tester) async {
    await tester.pump();

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: 4,
    );

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: 4,
    );

    // "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0"
    // var dragInitialPointElement = _seek.key('$INVENTORY_ITEM_KEY${_prods[0].id}');
    // await tester.drag(dragInitialPointElement, Offset(0.0, -50.0));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(1));

    expect(_seek.type(RefreshIndicator), findsNWidgets(1));
  }

  Future updateInventoryProduct(tester) async {
    await tester.pump();

    var newTitle = 'xxxxxx';
    var newDesc = 'xxxxxxxxxxxx';
    var updateButtonProduct1 =
        // _seek.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${_prods[0].id}');

        _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: 4,
    );

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: 3,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: 4,
    );

    // 1) Managed Products Page
    //   -> Click in 'First Product UpdateIcon'
    //   -> Open ManagedProductsAddEditPage(Product 01)
    await tester.tap(updateButtonProduct1);
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(1));

    // 2) ManagedProductsAddEditPage(Product 01)
    //   -> Checking the titlePage
    //   -> Page Form Fields
    expect(InventoryAddEditView, findsOneWidget);
    // expect(_seek.text(_prods[0].title), findsOneWidget);

    // 3) Change the product
    //   -> Title
    //   -> Description
    await tester.tap(_seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY));
    await tester.enterText(_seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY), newTitle);
    await tester.tap(_seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY));
    await tester.enterText(_seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY), newDesc);
    await tester.pump();
    await tester.pump(_seek.delay(2));

    // 4) Checking
    //   -> New title
    //   -> New Desccription
    //   -> Other fields
    expect(_seek.text(newTitle), findsOneWidget);
    // expect(_seek.text(_prods[0].price.toString()), findsOneWidget);
    expect(_seek.text(newDesc), findsOneWidget);
    // expect(_seek.text(_prods[0].imageUrl), findsOneWidget);

    // 5) Save form
    //   -> Test INValidation messages
    //   -> Back to Managed Products Page
    await tester.tap(_seek.key(INVENTORY_ADDEDIT_SAVEBUTTON_KEY));
    await tester.pump();
    await tester.pump(_seek.delay(4));
    expect(_seek.text(INVALID_TITLE_MSG), findsNothing);
    expect(_seek.text(INVALID_PRICE_MSG), findsNothing);
    expect(_seek.text(INVALID_DESCR_MSG), findsNothing);
    expect(_seek.text(INVALID_URL_MSG), findsNothing);

    // 6) Managed Products Page
    //   -> Checking the Updated Data
    expect(InventoryAddEditView, findsNothing);
    expect(_seek.text(INVENTORY_PAGE_TITLE), findsOneWidget);
    expect(_seek.text(newTitle), findsOneWidget);

    // 7) Click BackButton in Managed Products Page
    //   -> Go to Overview Page
    //   -> Checking the Updated Data in OverviewPage
    expect(_seek.type(BackButton), findsOneWidget);
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(1));
    expect(_seek.type(OverviewView), findsOneWidget);
    expect(_seek.text(newTitle), findsOneWidget);
  }

  Future deleteInventoryProduct(
    tester, {
    int initialQtde,
    int finalQtde,
    String keyTrigger,
    Type widgetType,
  }) async {
    await tester.pump();

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: initialQtde,
      widgetType: widgetType,
    );

    await tester.tap(_seek.key(keyTrigger));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(DELAY));

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: finalQtde,
      widgetType: widgetType,
    );

    _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: DELAY,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetQtde: 1,
      widgetType: OverviewGridItem,
    );
  }

  Future checkInventoryProducts(tester, int ProductsQtde) async {
    await tester.pump();

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: ProductsQtde,
    );
  }
}
