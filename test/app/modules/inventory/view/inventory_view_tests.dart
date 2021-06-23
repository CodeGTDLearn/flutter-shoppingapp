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

import '../../../../app_tests_config.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';

class InventoryViewTests {
  final TestUtils testUtils;
  final ViewTestUtils viewTestUtils;
  final testType;

  InventoryViewTests({this.testUtils, this.viewTestUtils, this.testType});

  Future tapingBackButtonInInventoryView(tester) async {
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    await viewTestUtils.navigationBetweenViews(
      tester,
      from: InventoryView,
      to: OverviewView,
      triggerElement: BackButton,
      delaySeconds: DELAY,
    );
  }

  Future checkInventoryProductsAbsence(tester, int delaySeconds) async {
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetType: InventoryItem,
    );

    expect(testUtils.text(NO_INVENTORY_PRODUCTS_FOUND_YET), findsOneWidget);

    await viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      triggerElement: BackButton,
    );
  }

  Future refreshingInventoryView(tester, {Product trigger}) async {
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    if (testType == false) {
      expect(testUtils.type(InventoryItem), findsNWidgets(2));
      await viewTestUtils.removeObjectFromDb(
        tester,
        url: PRODUCTS_URL,
        delaySeconds: 1,
        idElement: trigger.id,
      );
    }

    await tester.drag(
      testUtils.key('$INVENTORY_ITEM_KEY${trigger.id}'),
      Offset(0.0, 150.0),
    );

    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(1));
    expect(testUtils.type(RefreshIndicator), findsNWidgets(1));
    if (testType == false) expect(testUtils.type(InventoryItem), findsNWidgets(1));
  }

  Future updateInventoryProduct(
    tester, {
    String inputValidText,
    String fieldKey,
    int delaySeconds,
    Product productToUpdate,
  }) async {
    delaySeconds ??= DELAY;

    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    var keyUpdateButton =
        testUtils.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${productToUpdate.id}');

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
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
    if (testType == false) {
      await tester.pump(testUtils.delay(delaySeconds));
      expect(testUtils.type(InventoryView), findsOneWidget);
      expect(testUtils.text(inputValidText), findsOneWidget);

      // 5) Click InventoryView-BackButton
      //   -> Go to OverviewView + UpdatedValue
      await viewTestUtils.navigationBetweenViews(
        tester,
        delaySeconds: DELAY,
        from: InventoryView,
        to: OverviewView,
        triggerElement: BackButton,
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

    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    var keyUpdateButton =
        testUtils.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${productToUpdate.id}');

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
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
                  ? 'https://images.freeimages.com/images/large-previews/294/tomatoes-1326096.jpg'
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
    //          - They uses MOCK-OBJECTS which are not ' ACTUAL PERSISTED' IN DB
    //          - Without 'PERSISTENCE' in DB, InventoryAddEditView does not GO-BACK TO
    //          InventoryView automatically
    if (testType == false) {
      await tester.pump(testUtils.delay(delaySeconds));
      expect(testUtils.type(InventoryView), findsOneWidget);

      // 5) Click InventoryView-BackButton
      //   -> Go to OverviewView + UpdatedValue
      await viewTestUtils.navigationBetweenViews(
        tester,
        delaySeconds: DELAY,
        from: InventoryView,
        to: OverviewView,
        triggerElement: BackButton,
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
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: initialQtde,
      widgetType: widgetTypeToDelete,
    );

    await tester.tap(testUtils.key(keyDeleteButton));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetQtde: finalQtde,
      widgetType: widgetTypeToDelete,
    );

    await viewTestUtils.navigationBetweenViews(
      tester,
      delaySeconds: DELAY,
      from: InventoryView,
      to: OverviewView,
      triggerElement: BackButton,
    );

    viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: OverviewView,
      widgetQtde: 1,
      widgetType: OverviewGridItem,
    );
  }

  Future checkInventoryProducts(tester, int ProductsQtde) async {
    await viewTestUtils.testsInitialization(
      tester,
      testType: testType,
      appDriver: app.AppDriver(),
    );

    await tester.pump();

    await viewTestUtils.openDrawerAndClickAnOption(
      tester,
      delaySeconds: DELAY,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    viewTestUtils.checkWidgetsQtdeInOneView(
      widgetView: InventoryView,
      widgetType: InventoryItem,
      widgetQtde: ProductsQtde,
    );
  }

  //-------------------------TEST-METHODS-INVENTORY-EDIT-VIEW------------------------
  Future openInventoryEditView(tester) async {
    DRAWWER_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
    await tester.pumpAndSettle(testUtils.delay(2));
    await tester.tap(testUtils.key(DRAWER_INVENTORY_OPTION_KEY));
    await tester.pumpAndSettle(testUtils.delay(1));
    await tester.tap(testUtils.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
    await tester.pumpAndSettle(testUtils.delay(1));
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
    await ViewTestUtils().openDrawerAndClickAnOption(
      tester,
      delaySeconds: delaySeconds,
      clickedKeyOption: DRAWER_INVENTORY_OPTION_KEY,
      scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
    );

    expect(_seek.type(InventoryView), findsOneWidget);

    qtde ??= 1;
    for (var i = 1; i <= qtde; i++) {
      // C) CLICK IN INVENTORY-ADD-PRODUCT-BUTTON
      await ViewTestUtils().tapButtonWithResult(
        tester,
        delaySeconds: delaySeconds,
        keyWidgetTrigger: INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY,
        typeWidgetResult: InventoryEditView,
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
        validTexts
            ? "https://images.freeimages.com/images/large-previews/294/tomatoes-1326096.jpg"
            : invalidText,
      );

      await tester.pumpAndSettle(_seek.delay(delaySeconds));

      // E) CLICK IN SAVE-BUTTON + RETURN TO INVENTORY-VIEW + CHECK INVENTORY-ITEM ADDED
      await ViewTestUtils().tapButtonWithResult(
        tester,
        delaySeconds: delaySeconds,
        keyWidgetTrigger: INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY,
        typeWidgetResult: InventoryItem,
      );

      await tester.pumpAndSettle(_seek.delay(delaySeconds));
    }

    // F) CLICK IN BACK-BUTTON + RETURN FROM INVENTORY-VIEW TO OVERVIEW-VIEW
    await ViewTestUtils().navigationBetweenViews(
      tester,
      delaySeconds: delaySeconds,
      from: InventoryView,
      to: OverviewView,
      triggerElement: BackButton,
    );

    Get.delete(tag: 'localTestUtilsInstance');
  }

  Future addProductInInventoryEditPage(
    tester, {
    Product product,
    bool testUsingValidTexts,
  }) async {
    var validTitle, validPrice, validDesc, validImgUrl, invalidText;

    invalidText = "d";
    validTitle = product.title ?? "xxxxxx";
    validPrice = product.price.toString() ??
        Faker().randomGenerator.decimal(min: 20).toStringAsFixed(2);

    validDesc = product.description ?? "xxxxxxxxxxxxxx";
    validImgUrl = product.imageUrl ??
        "https://images.freeimages.com/images/large-previews/eae/clothes-3-1466560.jpg";

    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
    expect(testUtils.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);

    await tester.enterText(
      testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
      testUsingValidTexts ? validTitle : invalidText,
    );
    //Price is blocked against INVALID CONTENT, so there is no need to test it.
    // await tester.enterText(
    //   testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY),
    //   testUsingValidTexts ? validPrice : invalidText,
    // );
    await tester.enterText(
      testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
      testUsingValidTexts ? validDesc : invalidText,
    );
    await tester.enterText(
      testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
      testUsingValidTexts ? validImgUrl : invalidText,
    );

    await tester.pumpAndSettle(testUtils.delay(2));

    await tester.tap(testUtils.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
    await tester.pump();
    await tester.pump(testUtils.delay(2));
  }

  void expectTestingINValidationMessages(Matcher matcher) {
    expect(testUtils.text(SIZE_05_INVALID_MSG), matcher);
    // expect(_testUtils.text(PRICE_INVALID_MSG), matcher);
    expect(testUtils.text(SIZE_10_INVALID_MSG), matcher);
    expect(testUtils.text(URL_INVALID_MSG), matcher);
  }
}
