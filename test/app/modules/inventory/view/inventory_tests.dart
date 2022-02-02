import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/components/components_keys.dart';
import 'package:shopingapp/app/core/properties/db_urls.dart';
import 'package:shopingapp/app/core/texts/global_messages.dart';
import 'package:shopingapp/app/modules/inventory/core/components/custom_listtile/simple_listtile.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_labels.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_details_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/core/components/custom_grid_item/animated_grid_item.dart';
import 'package:shopingapp/app/modules/overview/core/overview_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
import '../../../../config/utils/finder_utils.dart';
import '../../../../config/utils/testdb_utils.dart';
import '../../../../config/utils/tests_utils.dart';
import '../../../../config/utils/ui_test_utils.dart';

class InventoryTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestDbUtils dbTestUtils;
  final TestsUtils testUtils;
  final _messages = Get.find<GlobalMessages>();
  final _labels = Get.put(InventoryLabels());
  final _keys = Get.find<ComponentsKeys>();
  final _keysOv = Get.find<OverviewKeys>();
  final _keysInv = Get.find<InventoryKeys>();

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
      applyDelay: true,
    );

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
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
      applyDelay: true,
    );

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: interval,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: InventoryView,
      widgetQtde: 0,
      widgetType: SimpleListTile,
    );

    expect(finder.text(_messages.no_inv_prod_yet), findsOneWidget);

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
      applyDelay: true,
    );

    await tester.pump();

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );

    if (!isWidgetTest) {
      expect(finder.type(SimpleListTile), findsWidgets);
      await dbTestUtils.removeObject(
        tester,
        url: PRODUCTS_URL,
        interval: DELAY,
        id: draggerWidget.id!,
      );
    }

    await tester.drag(
      finder.key('${_keysInv.k_inv_item_key}${draggerWidget.id}'),
      Offset(0.0, 150.0),
    );

    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(RefreshIndicator), findsNWidgets(1));
    if (!isWidgetTest) {
      expect(finder.type(SimpleListTile), findsNWidgets(qtdeAfterRefresh));
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
      applyDelay: true,
    );

    var keyUpdateButton = finder.key('${_keysInv.k_inv_upd_btn}${productToUpdate.id}');

    // 1) InventoryView
    //   -> Check 'InventoryView' + 'InventoryItem'
    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );
    expect(finder.type(InventoryView), findsOneWidget);
    expect(finder.type(SimpleListTile), findsWidgets);

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
    expect(finder.type(InventoryDetailsView), findsOneWidget);

    await tester.tap(finder.key(fieldKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.enterText(finder.key(fieldKey), inputValidText);
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(_keysInv.k_inv_edit_save_btn()));
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
      applyDelay: true,
    );

    var keyUpdateButton = finder.key('${_keysInv.k_inv_upd_btn}${productToUpdate.id}');

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );

    // 1) InventoryView
    //   -> Click in 'UpdateButton'
    //   -> Open InventoryAddEditView
    expect(finder.type(InventoryView), findsOneWidget);
    await tester.tap(keyUpdateButton);
    // await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(InventoryDetailsView), findsOneWidget);

    // 2) InventoryAddEditView
    //   -> Checking View + Title-Form-Field

    for (var i = 1; i <= 2; i++) {
      var isPriceField = fieldKey == _keysInv.k_inv_edit_fld_price;
      var isUrlField = fieldKey == _keysInv.k_inv_edit_fld_imgurl;

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
      await tester.tap(finder.key(_keysInv.k_inv_edit_save_btn()));
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
      applyDelay: true,
    );

    await tester.pump();

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
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
      widgetType: AnimatedGridItem,
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
      applyDelay: true,
    );

    await tester.pump();

    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: InventoryView,
      widgetType: SimpleListTile,
      widgetQtde: itemsQtde,
    );
  }

  //-------------------------TEST-METHODS-INVENTORY-EDIT-VIEW------------------------
  Future<void> openInventoryEditView(tester) async {
    await uiTestUtils.openDrawer_SelectAnOption(
      tester,
      interval: DELAY,
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(_keysInv.k_inv_add_btn_appbar()));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.type(InventoryDetailsView), findsOneWidget);
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
      optionKey: _keys.k_drw_inventory_opt4(),
      scaffoldGlobalKey: _keysOv.k_ov_scfld_glob_key(),
    );

    expect(_finder.type(InventoryView), findsOneWidget);

    // qtde ??= 1;
    for (var i = 1; i <= qtde; i++) {
      // C) CLICK IN INVENTORY-ADD-PRODUCT-BUTTON
      await UiTestUtils().tapButton_CheckResult(
        tester,
        interval: interval,
        triggerKey: _keysInv.k_inv_add_btn_appbar(),
        resultWidget: InventoryDetailsView,
      );

      // D) GENERATE PRE-BUIT CONTENT + CLICK IN THE TEXT-FIELDS + ADD CONTENT
      expect(_finder.text(_labels.inv_edt_lbl_title()), findsOneWidget);
      expect(_finder.text(_labels.inv_edt_lbl_price()), findsOneWidget);
      expect(_finder.text(_labels.inv_edt_lbl_descr()), findsOneWidget);
      expect(_finder.text(_labels.inv_edt_lbl_imgurl()), findsOneWidget);
      expect(_finder.text(_labels.inv_edt_img_tit()), findsOneWidget);

      invalidText = "d";
      await tester.enterText(
        _finder.key(_keysInv.k_inv_edit_fld_title()),
        validTexts ? "Red Tomatoes" : invalidText,
      );

      await tester.enterText(
        _finder.key(_keysInv.k_inv_edit_fld_price()),
        validTexts ? (99.99).toString() : invalidText,
      );

      await tester.enterText(
        _finder.key(_keysInv.k_inv_edit_fld_descr()),
        validTexts ? "The best Red tomatoes ever. It is super red!" : invalidText,
      );

      await tester.enterText(
        _finder.key(_keysInv.k_inv_edit_fld_imgurl()),
        validTexts ? TEST_IMAGE_URL_MAP.values.elementAt(0) : invalidText,
      );

      await tester.pumpAndSettle(testUtils.delay(interval));

      // E) CLICK IN SAVE-BUTTON + RETURN TO INVENTORY-VIEW + CHECK INVENTORY-ITEM ADDED
      await UiTestUtils().tapButton_CheckResult(
        tester,
        interval: interval,
        triggerKey: _keysInv.k_inv_edit_save_btn(),
        resultWidget: SimpleListTile,
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
      applyDelay: true,
    );

    await openInventoryEditView(tester);

    var validTitle, validPrice, validDesc, validImgUrl, invalidText;

    invalidText = "d";
    validTitle = product.title;
    validPrice = product.price.toString();
    validDesc = product.description;
    validImgUrl = product.imageUrl;

    expect(finder.text(_labels.inv_edt_lbl_title()), findsOneWidget);
    expect(finder.text(_labels.inv_edt_lbl_price()), findsOneWidget);
    expect(finder.text(_labels.inv_edt_lbl_descr()), findsOneWidget);
    expect(finder.text(_labels.inv_edt_lbl_imgurl()), findsOneWidget);

    await tester.enterText(
      finder.key(_keysInv.k_inv_edit_fld_title()),
      useValidTexts ? validTitle : invalidText,
    );
    //Price is blocked against INVALID CONTENT, so there is no need to test it.
    await tester.enterText(finder.key(_keysInv.k_inv_edit_fld_price()), validPrice);
    await tester.enterText(
      finder.key(_keysInv.k_inv_edit_fld_descr()),
      useValidTexts ? validDesc : invalidText,
    );
    await tester.enterText(
      finder.key(_keysInv.k_inv_edit_fld_imgurl()),
      useValidTexts ? validImgUrl : invalidText,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(_keysInv.k_inv_edit_save_btn()));
    await tester.pump(testUtils.delay(DELAY));

    useValidTexts
        ? expect(finder.type(RefreshIndicator), findsNWidgets(1))
        : _expectTestingINValidationMessages(findsOneWidget);

    useValidTexts
        ? expect(finder.type(InventoryView), findsOneWidget)
        : expect(finder.type(InventoryDetailsView), findsOneWidget);
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
      applyDelay: true,
    );

    await openInventoryEditView(tester);

    var validTitle, validDesc, validImgUrl, invalidText;

    invalidText = "d";
    validTitle = product.title;
    // validPrice = product.price.toString();
    validDesc = product.description;
    validImgUrl = product.imageUrl;

    expect(finder.text(_labels.inv_edt_lbl_title), findsOneWidget);
    expect(finder.text(_labels.inv_edt_lbl_price), findsOneWidget);
    expect(finder.text(_labels.inv_edt_lbl_descr), findsOneWidget);
    expect(finder.text(_labels.inv_edt_lbl_imgurl), findsOneWidget);

    await tester.enterText(
      finder.key(_keysInv.k_inv_edit_fld_title()),
      useValidTexts ? validTitle : invalidText,
    );
    //Price is blocked against INVALID CONTENT, so there is no need to test it.
    await tester.enterText(finder.key(_keysInv.k_inv_edit_fld_price()), '2');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$0.02'), findsOneWidget);

    await tester.enterText(finder.key(_keysInv.k_inv_edit_fld_price()), '22');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$0.22'), findsOneWidget);

    await tester.enterText(finder.key(_keysInv.k_inv_edit_fld_price()), '222');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$2.22'), findsOneWidget);

    await tester.enterText(finder.key(_keysInv.k_inv_edit_fld_price()), '2222');
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text('\$22.22'), findsOneWidget);

    await tester.enterText(
      finder.key(_keysInv.k_inv_edit_fld_descr()),
      useValidTexts ? validDesc : invalidText,
    );
    await tester.enterText(
      finder.key(_keysInv.k_inv_edit_fld_imgurl()),
      useValidTexts ? validImgUrl : invalidText,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await tester.tap(finder.key(_keysInv.k_inv_edit_save_btn()));
    await tester.pump(testUtils.delay(DELAY));

    useValidTexts
        ? expect(finder.type(RefreshIndicator), findsNWidgets(1))
        : _expectTestingINValidationMessages(findsOneWidget);

    useValidTexts
        ? expect(finder.type(InventoryView), findsOneWidget)
        : expect(finder.type(InventoryDetailsView), findsOneWidget);
  }

  Future<void> edit_back_button(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await openInventoryEditView(tester);

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: InventoryDetailsView,
      to: InventoryView,
      trigger: BackButton,
      interval: DELAY,
    );
  }

  void _expectTestingINValidationMessages(Matcher matcher) {
    expect(finder.text(_messages.size_05_inval_message), matcher);
    expect(finder.text(_messages.size_10_inval_message), matcher);
    expect(finder.text(_messages.format_url_message), matcher);
  }
}