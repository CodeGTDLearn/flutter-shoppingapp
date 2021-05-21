import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../app_tests_config.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class InventoryViewTests {
  final _seek = TestUtils();
  final _viewTestUtils = ViewTestUtils();

  final _prods = ProductsMockedDatasource().products();

  Future tapingViewBackButton_In_InventoryView(tester) async {
    await checkProductsInInventoryView(tester, 1);

    expect(_seek.type(BackButton), findsOneWidget);
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(DELAY));
    expect(_seek.type(OverviewView), findsOneWidget);
  }

  Future OpenInventoryView_NoOrderInDB(
    WidgetTester tester,
    int delaySeconds,
  ) async {

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(_seek.text(NO_INVENTORY_PRODUCTS_FOUND_YET), findsOneWidget);

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetElement: InventoryItem,
    );

    await _viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future refreshingInventoryView_checkRefreshIndicator(tester) async {
    await tester.pump();

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetElement: OverviewGridItem,
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
      widgetElement: InventoryItem,
      widgetQtde: 4,
    );

    var dragInitialPointElement = _seek.key('$INVENTORY_ITEM_KEY${_prods[0].id}');
    await tester.drag(dragInitialPointElement, Offset(0.0, -50.0));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(1));

    expect(_seek.type(RefreshIndicator), findsNWidgets(1));
  }

  Future updateProduct(tester) async {
    await tester.pump();

    var newTitle = 'xxxxxx';
    var newDesc = 'xxxxxxxxxxxx';
    var updateButtonProduct1 =
        _seek.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${_prods[0].id}');
    var titleFieldKey = _seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY);
    var descFieldKey = _seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY);
    var saveButtonKey = _seek.key(INVENTORY_ADDEDIT_SAVEBUTTON_KEY);
    var manProdAddEditPageTitle = _seek.text(INVENTORY_ADDEDIT_TITLEPAGE_EDIT);

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetElement: OverviewGridItem,
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
      widgetElement: InventoryItem,
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
    expect(manProdAddEditPageTitle, findsOneWidget);
    expect(_seek.text(_prods[0].title), findsOneWidget);
    expect(_seek.text(_prods[0].price.toString()), findsOneWidget);
    expect(_seek.text(_prods[0].description), findsOneWidget);
    expect(_seek.text(_prods[0].imageUrl), findsOneWidget);

    // 3) Change the product
    //   -> Title
    //   -> Description
    await tester.tap(titleFieldKey);
    await tester.enterText(titleFieldKey, newTitle);
    await tester.tap(descFieldKey);
    await tester.enterText(descFieldKey, newDesc);
    await tester.pump();
    await tester.pump(_seek.delay(2));

    // 4) Checking
    //   -> New title
    //   -> New Desccription
    //   -> Other fields
    expect(_seek.text(newTitle), findsOneWidget);
    expect(_seek.text(_prods[0].price.toString()), findsOneWidget);
    expect(_seek.text(newDesc), findsOneWidget);
    expect(_seek.text(_prods[0].imageUrl), findsOneWidget);

    // 5) Save form
    //   -> Test INValidation messages
    //   -> Back to Managed Products Page
    await tester.tap(saveButtonKey);
    await tester.pump();
    await tester.pump(_seek.delay(4));
    expect(_seek.text(INVALID_TITLE_MSG), findsNothing);
    expect(_seek.text(INVALID_PRICE_MSG), findsNothing);
    expect(_seek.text(INVALID_DESCR_MSG), findsNothing);
    expect(_seek.text(INVALID_URL_MSG), findsNothing);

    // 6) Managed Products Page
    //   -> Checking the Updated Data
    expect(manProdAddEditPageTitle, findsNothing);
    expect(_seek.text(INVENTORY_PAGE_TITLE), findsOneWidget);
    expect(_seek.text(newTitle), findsOneWidget);

    // 7) Click BackButton in Managed Products Page
    //   -> Go to Overview Page
    //   -> Checking the Updated Data in OverviewPage
    expect(_seek.type(BackButton), findsOneWidget);
    await tester.tap(_seek.type(BackButton));
    await tester.pumpAndSettle(_seek.delay(1));
    expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    expect(_seek.text(newTitle), findsOneWidget);
  }

  Future deleteProduct(
    tester, {
    int initialQtde,
    int finalQtde,
    String keyTrigger,
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
      widgetElement: InventoryItem,
      widgetQtde: initialQtde,
    );

    await tester.tap(_seek.key(keyTrigger));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(DELAY));

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetElement: InventoryItem,
      widgetQtde: finalQtde,
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
      widgetElement: OverviewGridItem,
    );
  }

  Future checkProductsInInventoryView(tester, int ProductsQtde) async {
    await tester.pump();

    await _viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      keyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    _viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetElement: InventoryItem,
      widgetQtde: ProductsQtde,
    );
  }
}
