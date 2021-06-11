import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewFunctionalTests {
  bool _unitTest;
  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());
  final _utils = Get.put(ViewTestUtils());

  InventoryViewFunctionalTests({String testType}) {
    _unitTest = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _unitTest);
    });

    tearDown(() {
      _utils.globalTearDown("...Ending");
      Get.reset;
    });

    testWidgets('${_config.checking_ProductsAbsence}', (tester) async {
      if (_unitTest == false) await _cleanDb(tester);
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    });

    testWidgets('${_config.checking_Products}', (tester) async {
      if (!_unitTest) {
        await _cleanDb(tester);
        await _utils.addObjectsInDb(tester,
            qtdeObjects: 2,
            collectionUrl: PRODUCTS_URL,
            object: ProductDataBuilder().ProductFullStaticNoId(),
            delaySeconds: DELAY);
      }

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      _unitTest
          ? await _tests.checkInventoryProducts(tester, 4)
          : await _tests.checkInventoryProducts(tester, 2);
    });

    testWidgets('${_config.deleting_Product}', (tester) async {
      var product = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.deleteInventoryProduct(tester,
          initialQtde: 2,
          finalQtde: 1,
          keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${product.id}',
          widgetTypeToDelete: InventoryItem);
    });

    testWidgets('${_config.updating_Product}', (tester) async {
      var product = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.updateInventoryProduct(
        tester,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: product,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.testing_RefreshingView}', (tester) async {
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.refreshingInventoryView(tester);
    }, skip: true);

    testWidgets('${_config.testing_BackButtonInView}', (tester) async {
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _utils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_INVENTORY_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      await _tests.tapingBackButtonInInventoryView(tester);
    });

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets('${_config.validation_title_05MinSize}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: SIZE_05_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.validation_title_emptyNotAllowed}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.validation_title_injectionScript}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: TEXT_NUMBER_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    //DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets('${_config.validation_descript_10MinSize}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: SIZE_10_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.validation_descript_EmptyNotAllowed}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.validation_descript_injectionScript}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: TEXT_NUMBER_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    //PRICE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets('${_config.validation_price_EmptyNotAllowed}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.validation_price_injectionScript}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.validation_price_06MaxSize}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInputInjectionOrInputValidation(
        tester,
        //se inserir texto tem que falhar no price, numero tera' que formatar in realtime
        injectionTextOrInvalidText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });
  }

  Future<dynamic> _testProduct(tester, {bool unitTest}) async {
    var _product;

    if (!unitTest) {
      await _cleanDb(tester);
      await _utils
          .addObjectsInDb(tester,
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY)
          .then((value) => _product = value[0]);
    }

    return unitTest ? ProductsMockedDatasource().products()[0] : _product;
  }

  Future _cleanDb(tester) async {
    await _utils.removeDbCollection(tester, url: ORDERS_URL, delaySeconds: 1);
    await _utils.removeDbCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _utils.removeDbCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
