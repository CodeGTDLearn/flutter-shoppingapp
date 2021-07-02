import 'package:faker/faker.dart';
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
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class InventoryTests {
  final bool isWidgetTest;
  final TestUtils testUtils;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;

  InventoryTests({
    this.testUtils,
    this.uiTestUtils,
    this.isWidgetTest,
    this.dbTestUtils,
  });

  Future tapingBackButtonInInventoryView(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await uiTestUtils.navigationBetweenViews(
      tester,
      from: InventoryView,
      to: OverviewView,
      triggerWidget: BackButton,
      delaySeconds: DELAY,
    );
  }

  Future checkInventoryProductsAbsence(tester, int delaySeconds) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetType: InventoryItem,
    );

    expect(testUtils.text(NO_INVENTORY_PRODUCTS_FOUND_YET), findsOneWidget);

    await uiTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      triggerWidget: BackButton,
    );
  }

  Future refreshingInventoryView(tester, {Product triggerProduct}) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    if (isWidgetTest == false) {
      expect(testUtils.type(InventoryItem), findsNWidgets(2));
      await dbTestUtils.removeObject(
        tester,
        url: PRODUCTS_URL,
        delaySeconds: DELAY,
        id: triggerProduct.id,
      );
    }

    await tester.drag(
      testUtils.key('$INVENTORY_ITEM_KEY${triggerProduct.id}'),
      Offset(0.0, 150.0),
    );

    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.type(RefreshIndicator), findsNWidgets(1));
    if (isWidgetTest == false) expect(testUtils.type(InventoryItem), findsNWidgets(1));
  }

  Future updateInventoryProduct(
    tester, {
    String inputValidText,
    String fieldKey,
    int delaySeconds,
    Product productToUpdate,
  }) async {
    delaySeconds ??= DELAY;

    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var keyUpdateButton =
        testUtils.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${productToUpdate.id}');

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    // 1) InventoryView
    //   -> Check 'CurrentTitle'
    //   -> Click in 'UpdateButton'
    //   -> Open InventoryAddEditView
    expect(testUtils.type(InventoryView), findsOneWidget);
    expect(testUtils.text(productToUpdate.title), findsWidgets);
    await tester.tap(keyUpdateButton);
    await tester.pump(testUtils.delay(delaySeconds));

    // 2) InventoryAddEditView
    //   -> Checking View + Title-Form-Field
    await tester.pump();
    expect(testUtils.type(InventoryEditView), findsOneWidget);
    expect(testUtils.text(productToUpdate.title), findsWidgets);

    // 3) InventoryAddEditView
    //   -> Insert 'UpdatedValue' in Page-Form-Field
    //   -> Checking the change
    // await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY));
    await tester.tap(testUtils.key(fieldKey));
    await tester.enterText(testUtils.key(fieldKey), inputValidText);
    await tester.pump(testUtils.delay(delaySeconds));

    // 4) Save form
    //   -> Tap Saving:
    //      - ONLY IN FUNCTIONAL-TESTS: Backing to InventoryView automatically
    //   -> Test existence of INValidation messages
    //   -> Go to InventoryView + Checking UpdatedValue
    await tester.tap(testUtils.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pump(testUtils.delay(delaySeconds));

    // 4.1) Save form
    //   -> Tap Saving:
    //      - UNIT-TESTS: DO NOT Backing to InventoryView automatically
    //        - THEREFORE: _unitTests DOES NOT EXECUTE THIS 'TEST-PHASE', because:
    //          - They uses MOCK-OBJECTS which are not 'PERSISTED' IN DB
    //          - Without 'PERSISTENCE' in DB InventoryAddEditView does not GO-BACK
    //          InventoryView automatically
    if (isWidgetTest == false) {
      await tester.pump(testUtils.delay(delaySeconds));
      expect(testUtils.type(InventoryView), findsOneWidget);
      expect(testUtils.text(inputValidText), findsOneWidget);

      // 5) Click InventoryView-BackButton
      //   -> Go to OverviewView + UpdatedValue
      await uiTestUtils.navigationBetweenViews(
        tester,
        delaySeconds: DELAY,
        from: InventoryView,
        to: OverviewView,
        triggerWidget: BackButton,
      );
      expect(testUtils.text(inputValidText), findsOneWidget);
    }
  }

  Future checkInputInjectionOrInputValidation(
    tester, {
    String injectionTextOrInvalidText,
    String fieldKey,
    String shownValidationErrorMessage,
    int delaySeconds,
    Product productToUpdate,
  }) async {
    delaySeconds ??= DELAY;

    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var keyUpdateButton =
        testUtils.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${productToUpdate.id}');

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    // 1) InventoryView
    //   -> Check 'CurrentTitle'
    //   -> Click in 'UpdateButton'
    //   -> Open InventoryAddEditView
    expect(testUtils.type(InventoryView), findsOneWidget);
    expect(testUtils.text(productToUpdate.title), findsWidgets);
    await tester.tap(keyUpdateButton);
    await tester.pump(testUtils.delay(delaySeconds));

    // 2) InventoryAddEditView
    //   -> Checking View + Title-Form-Field
    await tester.pump();
    expect(testUtils.type(InventoryEditView), findsOneWidget);
    expect(testUtils.text(productToUpdate.title), findsWidgets);

    for (var i = 1; i <= 2; i++) {
      var isPriceField = fieldKey == INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY;
      var isUrlField = fieldKey == INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY;

      injectionTextOrInvalidText = i == 1
          ? injectionTextOrInvalidText
          : isPriceField
              ? '99.99'
              : isUrlField
                  ? IMAGE1_TEST_URL
                  : 'validTexts';

      // 3) InventoryAddEditView
      //   -> Insert 'UpdatedValue' in Page-Form-Field
      //   -> Checking the change
      // await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY));
      await tester.tap(testUtils.key(fieldKey));
      await tester.enterText(testUtils.key(fieldKey), injectionTextOrInvalidText);
      await tester.pump(testUtils.delay(delaySeconds));

      // 4) Save form
      //   -> Tap Saving:
      //      - ONLY IN FUNCTIONAL-TESTS: Backing to InventoryView automatically
      //   -> Test existence of INValidation messages
      //   -> Go to InventoryView + Checking UpdatedValue
      await tester.tap(testUtils.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
      await tester.pump(testUtils.delay(delaySeconds));

      if (i == 1) expect(testUtils.text(shownValidationErrorMessage), findsWidgets);

      await tester.pump(testUtils.delay(delaySeconds));
    }

    // 4.1) Save form
    //   -> Tap Saving:
    //      - UNIT-TESTS: DO NOT Backing to InventoryView automatically
    //        - THEREFORE: _unitTests DOES NOT EXECUTE THIS 'TEST-PHASE', because:
    //          - They uses MOCK-OBJECTS which are not 'ACTUAL PERSISTED' IN the DB
    //          - Without 'PERSISTENCE' in DB, InventoryEditView does not GO-BACK TO
    //          InventoryView automatically
    if (isWidgetTest == false) {
      await tester.pump(testUtils.delay(delaySeconds));
      expect(testUtils.type(InventoryView), findsOneWidget);

      // 5) Click InventoryView-BackButton
      //   -> Go to OverviewView + UpdatedValue
      await uiTestUtils.navigationBetweenViews(
        tester,
        delaySeconds: DELAY,
        from: InventoryView,
        to: OverviewView,
        triggerWidget: BackButton,
      );
    }
  }

  Future deleteInventoryProduct(
    tester, {
    int initialQtde,
    int finalQtde,
    String keyDeleteButton,
    Type widgetTypeToDelete,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: initialQtde,
      widgetType: widgetTypeToDelete,
    );

    await tester.tap(testUtils.key(keyDeleteButton));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    uiTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: finalQtde,
      widgetType: widgetTypeToDelete,
    );

    await uiTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: DELAY,
      from: InventoryView,
      to: OverviewView,
      triggerWidget: BackButton,
    );

    uiTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetQtde: 1,
      widgetType: OverviewGridItem,
    );
  }

  Future checkInventoryViewProducts(tester, int ProductsQtde) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    uiTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: ProductsQtde,
    );
  }

  //-------------------------TEST-METHODS-INVENTORY-EDIT-VIEW------------------------
  Future openInventoryEditView(tester) async {
    await uiTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(testUtils.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(testUtils.type(InventoryEditView), findsOneWidget);
  }

  Future AddProductInDb(
    WidgetTester tester, {
    int delaySeconds,
    bool validTexts,
    int qtde,
  }) async {
    var invalidText;
    var _seek = Get.put(TestUtils(), tag: 'localTestUtilsInstance');

    // A) OPEN DRAWER
    // B) CLICK IN INVENTORY-DRAWER-OPTION
    await UiTestUtils().openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      optionKey: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(_seek.type(InventoryView), findsOneWidget);

    qtde ??= 1;
    for (var i = 1; i <= qtde; i++) {
      // C) CLICK IN INVENTORY-ADD-PRODUCT-BUTTON
      await UiTestUtils().tapButtonWithResult(
        tester,
        delaySeconds: delaySeconds,
        triggerKey: INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY,
        resultWidget: InventoryEditView,
      );

      // D) GENERATE PRE-BUIT CONTENT + CLICK IN THE TEXT-FIELDS + ADD CONTENT
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_IMAGE_TITLE), findsOneWidget);

      invalidText = "d";
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
        validTexts ? "Red Tomatoes" : invalidText,
      );

      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY),
        validTexts ? (99.99).toString() : invalidText,
      );

      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
        validTexts ? "The best Red tomatoes ever. It is super red!" : invalidText,
      );

      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
        validTexts ? IMAGE1_TEST_URL : invalidText,
      );

      await tester.pumpAndSettle(_seek.delay(delaySeconds));

      // E) CLICK IN SAVE-BUTTON + RETURN TO INVENTORY-VIEW + CHECK INVENTORY-ITEM ADDED
      await UiTestUtils().tapButtonWithResult(
        tester,
        delaySeconds: delaySeconds,
        triggerKey: INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY,
        resultWidget: InventoryItem,
      );

      await tester.pumpAndSettle(_seek.delay(delaySeconds));
    }

    // F) CLICK IN BACK-BUTTON + RETURN FROM INVENTORY-VIEW TO OVERVIEW-VIEW
    await UiTestUtils().navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      triggerWidget: BackButton,
    );

    Get.delete(tag: 'localTestUtilsInstance');
  }

  Future addProductFillingFormInInventoryEditView(
    tester, {
    Product product,
    bool useValidTexts,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await openInventoryEditView(tester);

    var validTitle, validPrice, validDesc, validImgUrl, invalidText;

    invalidText = "d";
    validTitle = product.title ?? "xxxxxx";
    validPrice = product.price.toString() ??
        Faker().randomGenerator.decimal(min: 20).toStringAsFixed(2);

    validDesc = product.description ?? "xxxxxxxxxxxxxx";
    validImgUrl = product.imageUrl ?? IMAGE1_TEST_URL;

    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);

    await tester.enterText(
      testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
      useValidTexts ? validTitle : invalidText,
    );
    //Price is blocked against INVALID CONTENT, so there is no need to test it.
    await tester.enterText(
        testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY), validPrice);
    await tester.enterText(
      testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
      useValidTexts ? validDesc : invalidText,
    );
    await tester.enterText(
      testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
      useValidTexts ? validImgUrl : invalidText,
    );

    await tester.pumpAndSettle(testUtils.delay(2));

    await tester.tap(testUtils.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pump();
    await tester.pump(testUtils.delay(2));

    useValidTexts
        ? expect(testUtils.type(RefreshIndicator), findsNWidgets(1))
        : _expectTestingINValidationMessages(findsOneWidget);

    useValidTexts
        ? expect(testUtils.type(InventoryView), findsOneWidget)
        : expect(testUtils.type(InventoryEditView), findsOneWidget);
  }

  void _expectTestingINValidationMessages(Matcher matcher) {
    expect(testUtils.text(SIZE_05_INVALID_MSG), matcher);
    // expect(_testUtils.text(PRICE_INVALID_MSG), matcher);
    expect(testUtils.text(SIZE_10_INVALID_MSG), matcher);
    expect(testUtils.text(URL_INVALID_MSG), matcher);
  }

  Future tapBackButtonInInventoryEditView(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    await openInventoryEditView(tester);

    await uiTestUtils.navigationBetweenViews(
      tester,
      from: InventoryEditView,
      to: InventoryView,
      triggerWidget: BackButton,
      delaySeconds: DELAY,
    );
  }
}
