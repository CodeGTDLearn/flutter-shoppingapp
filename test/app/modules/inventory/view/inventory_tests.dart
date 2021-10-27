import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/tests_properties.dart';
import '../../../../utils/dbtest_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class InventoryTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;
  final TestsUtils testUtils;

  InventoryTests({
    required this.isWidgetTest,
    required this.finder,
    required this.uiTestUtils,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> tap_viewBackButton(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
      interval: DELAY,
    );
  }

  Future<void> check_emptyView_noProductInDb(tester, int interval) async {
    if (!isWidgetTest) {
      await dbTestUtils.removeCollection(tester,
          url: TESTDB_PRODUCTS_URL, interval: DELAY);
    }

    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: interval,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetType: InventoryItem,
    );

    expect(finder.text(NO_INVENTORY_PRODUCTS_FOUND_YET), findsOneWidget);

    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: interval,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );
  }

  Future<void> refresh_view(
    WidgetTester tester, {
    required Product draggerWidget,
    required int qtdeAfterRefresh,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    if (!isWidgetTest) {
      expect(finder.type(InventoryItem), findsWidgets);
      await dbTestUtils.removeObject(
        tester,
        url: PRODUCTS_URL,
        interval: DELAY,
        id: draggerWidget.id!,
      );
    }

    await tester.drag(
      finder.key('$INVENTORY_ITEM_KEY${draggerWidget.id}'),
      Offset(0.0, 150.0),
    );

    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(RefreshIndicator), findsNWidgets(1));
    if (!isWidgetTest) {
      expect(finder.type(InventoryItem), findsNWidgets(qtdeAfterRefresh));
    }
  }

  Future<void> update_product(
    WidgetTester tester, {
    required String inputValidText,
    required String fieldKey,
    required Product productToUpdate,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var keyUpdateButton =
        finder.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${productToUpdate.id}');

    // 1) InventoryView
    //   -> Check 'InventoryView' + 'InventoryItem'
    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );
    expect(finder.type(InventoryView), findsOneWidget);
    expect(finder.type(InventoryItem), findsWidgets);

    // 2) UpdateButton
    //   -> Click in 'UpdateButton'
    //   -> Open InventoryAddEditView
    await tester.tap(keyUpdateButton);
    await tester.pump(testUtils.delay(DELAY));

    // 3) InventoryAddEditView
    //   -> Checking View + Title-Form-Field
    //   -> Insert 'UpdatedValue' in Page-Form-Field
    //   -> Checking the change
    //   -> Tap Saving:
    //      - ONLY IN FUNCTIONAL-TESTS: Backing to InventoryView automatically
    //   -> Test existence of INValidation messages
    //   -> Go to InventoryView + Checking UpdatedValue
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(InventoryEditView), findsOneWidget);

    await tester.tap(finder.key(fieldKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.enterText(finder.key(fieldKey), inputValidText);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    // 3.1) Save form
    //   -> Tap Saving:
    //      - UNIT-TESTS: DO NOT Backing to InventoryView automatically
    //        - THEREFORE: _unitTests DOES NOT EXECUTE THIS 'TEST-PHASE', because:
    //          - They uses MOCK-OBJECTS which are not 'PERSISTED' IN DB
    //          - Without 'PERSISTENCE' in DB InventoryAddEditView does not GO-BACK
    //          InventoryView automatically
    if (!isWidgetTest) {
      await tester.pump(testUtils.delay(DELAY));
      expect(finder.type(InventoryView), findsOneWidget);
      expect(finder.text(inputValidText), findsOneWidget);

      // 4) Click InventoryView-BackButton
      //   -> Go to OverviewView + UpdatedValue
      await uiTestUtils.navigateBetweenViews(
        tester,
        interval: DELAY,
        from: InventoryView,
        to: OverviewView,
        trigger: BackButton,
      );
      expect(finder.text(inputValidText), findsOneWidget);
    }
  }

  Future<void> check_Injection_Validation(
    WidgetTester tester, {
    required String inputText,
    required String fieldKey,
    required String validationErrorMessage,
    required Product productToUpdate,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var keyUpdateButton =
        finder.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${productToUpdate.id}');

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    // 1) InventoryView
    //   -> Click in 'UpdateButton'
    //   -> Open InventoryAddEditView
    expect(finder.type(InventoryView), findsOneWidget);
    await tester.tap(keyUpdateButton);
    // await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(InventoryEditView), findsOneWidget);

    // 2) InventoryAddEditView
    //   -> Checking View + Title-Form-Field

    for (var i = 1; i <= 2; i++) {
      var isPriceField = fieldKey == INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY;
      var isUrlField = fieldKey == INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY;

      inputText = i == 1
          ? inputText
          : isPriceField
              ? '99.99'
              : isUrlField
                  ? TEST_IMAGE_URL_MAP.values.elementAt(0)
                  : 'validTexts';

      // 3) InventoryAddEditView
      //   -> Insert 'UpdatedValue' in Page-Form-Field
      //   -> Checking the change
      await tester.tap(finder.key(fieldKey));
      // await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      await tester.enterText(finder.key(fieldKey), inputText);
      // await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));

      // 4) Save form
      //   -> Tap Saving:
      //      - ONLY IN FUNCTIONAL-TESTS: Backing to InventoryView automatically
      //   -> Test existence of INValidation messages
      //   -> Go to InventoryView + Checking UpdatedValue
      await tester.tap(finder.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
      // await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));

      if (i == 1) expect(finder.text(validationErrorMessage), findsWidgets);

      // await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
    }

    // 4.1) Save form
    //   -> Tap Saving:
    //      - UNIT-TESTS: DO NOT Backing to InventoryView automatically
    //        - THEREFORE: _unitTests DOES NOT EXECUTE THIS 'TEST-PHASE', because:
    //          - They uses MOCK-OBJECTS which are not 'ACTUAL PERSISTED' IN the DB
    //          - Without 'PERSISTENCE' in DB, InventoryEditView does not GO-BACK TO
    //          InventoryView automatically
    if (isWidgetTest == false) {
      // await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(finder.type(InventoryView), findsOneWidget);

      // 5) Click InventoryView-BackButton
      //   -> Go to OverviewView + UpdatedValue
      await uiTestUtils.navigateBetweenViews(
        tester,
        interval: DELAY,
        from: InventoryView,
        to: OverviewView,
        trigger: BackButton,
      );
    }
  }

  Future<void> delete_product(
    WidgetTester tester, {
    required int qtdeAfterDelete,
    required String deleteButtonKey,
    required Type widgetTypetoBeDeleted,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await tester.tap(finder.key(deleteButtonKey));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.check_widgetQuantityInAView(
        widgetView: InventoryView,
        widgetQtde: qtdeAfterDelete,
        widgetType: widgetTypetoBeDeleted);

    await uiTestUtils.navigateBetweenViews(
      tester,
      interval: DELAY,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: OverviewView,
      widgetQtde: qtdeAfterDelete,
      widgetType: OverviewGridItem,
    );
  }

  Future<void> check_qtde_products(
    tester,
    int itemsQtde,
  ) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: itemsQtde,
    );
  }

  //-------------------------TEST-METHODS-INVENTORY-EDIT-VIEW------------------------
  Future<void> openInventoryEditView(tester) async {
    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(InventoryEditView), findsOneWidget);
  }

  Future<void> AddProductInDb(
    WidgetTester tester, {
    required int interval,
    required bool validTexts,
    required int qtde,
  }) async {
    var invalidText;
    var _finder = Get.put(FinderUtils(), tag: 'localTestUtilsInstance');

    // A) OPEN DRAWER
    // B) CLICK IN INVENTORY-DRAWER-OPTION
    await UiTestUtils().openDrawer_SelectAnOption(
      tester,
      interval: interval,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(_finder.type(InventoryView), findsOneWidget);

    // qtde ??= 1;
    for (var i = 1; i <= qtde; i++) {
      // C) CLICK IN INVENTORY-ADD-PRODUCT-BUTTON
      await UiTestUtils().tapButton_CheckResult(
        tester,
        interval: interval,
        triggerKey: INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY,
        resultWidget: InventoryEditView,
      );

      // D) GENERATE PRE-BUIT CONTENT + CLICK IN THE TEXT-FIELDS + ADD CONTENT
      expect(_finder.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
      expect(_finder.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
      expect(_finder.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
      expect(_finder.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);
      expect(_finder.text(INVENTORY_ADDEDIT_IMAGE_TITLE), findsOneWidget);

      invalidText = "d";
      await tester.enterText(
        _finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
        validTexts ? "Red Tomatoes" : invalidText,
      );

      await tester.enterText(
        _finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY),
        validTexts ? (99.99).toString() : invalidText,
      );

      await tester.enterText(
        _finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
        validTexts ? "The best Red tomatoes ever. It is super red!" : invalidText,
      );

      await tester.enterText(
        _finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
        validTexts ? TEST_IMAGE_URL_MAP.values.elementAt(0) : invalidText,
      );

      await tester.pumpAndSettle(testUtils.delay(interval));

      // E) CLICK IN SAVE-BUTTON + RETURN TO INVENTORY-VIEW + CHECK INVENTORY-ITEM ADDED
      await UiTestUtils().tapButton_CheckResult(
        tester,
        interval: interval,
        triggerKey: INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY,
        resultWidget: InventoryItem,
      );

      await tester.pumpAndSettle(testUtils.delay(interval));
    }

    // F) CLICK IN BACK-BUTTON + RETURN FROM INVENTORY-VIEW TO OVERVIEW-VIEW
    await UiTestUtils().navigateBetweenViews(
      tester,
      interval: interval,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
    );

    Get.delete(tag: 'localTestUtilsInstance');
  }

  Future<void> add_product_using_edit_form(
    WidgetTester tester, {
    required Product product,
    required bool useValidTexts,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await openInventoryEditView(tester);

    var validTitle, validPrice, validDesc, validImgUrl, invalidText;

    invalidText = "d";
    validTitle = product.title;
    validPrice = product.price.toString();
    validDesc = product.description;
    validImgUrl = product.imageUrl;

    expect(finder.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
    expect(finder.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
    expect(finder.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
    expect(finder.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);

    await tester.enterText(
      finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
      useValidTexts ? validTitle : invalidText,
    );
    //Price is blocked against INVALID CONTENT, so there is no need to test it.
    await tester.enterText(
        finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY), validPrice);
    await tester.enterText(
      finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
      useValidTexts ? validDesc : invalidText,
    );
    await tester.enterText(
      finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
      useValidTexts ? validImgUrl : invalidText,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pump(testUtils.delay(DELAY));

    useValidTexts
        ? expect(finder.type(RefreshIndicator), findsNWidgets(1))
        : _expectTestingINValidationMessages(findsOneWidget);

    useValidTexts
        ? expect(finder.type(InventoryView), findsOneWidget)
        : expect(finder.type(InventoryEditView), findsOneWidget);
  }

  Future<void> test_auto_currency_in_form(
    WidgetTester tester, {
    required Product product,
    required bool useValidTexts,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await openInventoryEditView(tester);

    var validTitle, validDesc, validImgUrl, invalidText;

    invalidText = "d";
    validTitle = product.title;
    // validPrice = product.price.toString();
    validDesc = product.description;
    validImgUrl = product.imageUrl;

    expect(finder.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
    expect(finder.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
    expect(finder.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
    expect(finder.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);

    await tester.enterText(
      finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
      useValidTexts ? validTitle : invalidText,
    );
    //Price is blocked against INVALID CONTENT, so there is no need to test it.
    await tester.enterText(finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY), '2');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$0.02'), findsOneWidget);

    await tester.enterText(finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY), '22');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$0.22'), findsOneWidget);

    await tester.enterText(finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY), '222');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$2.22'), findsOneWidget);

    await tester.enterText(finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY), '2222');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$22.22'), findsOneWidget);

    await tester.enterText(
      finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
      useValidTexts ? validDesc : invalidText,
    );
    await tester.enterText(
      finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
      useValidTexts ? validImgUrl : invalidText,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pump(testUtils.delay(DELAY));

    useValidTexts
        ? expect(finder.type(RefreshIndicator), findsNWidgets(1))
        : _expectTestingINValidationMessages(findsOneWidget);

    useValidTexts
        ? expect(finder.type(InventoryView), findsOneWidget)
        : expect(finder.type(InventoryEditView), findsOneWidget);
  }

  Future<void> edit_back_button(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await openInventoryEditView(tester);

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: InventoryEditView,
      to: InventoryView,
      trigger: BackButton,
      interval: DELAY,
    );
  }

  void _expectTestingINValidationMessages(Matcher matcher) {
    expect(finder.text(SIZE_05_INVALID_ERROR_MSG), matcher);
    expect(finder.text(SIZE_10_INVALID_ERROR_MSG), matcher);
    expect(finder.text(URL_INVALID_ERROR_MSG), matcher);
  }
}
