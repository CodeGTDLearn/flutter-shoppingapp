import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
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

class InventoryViewValidationTest {
  bool _unitTest;
  final bool _skipTest = false;
  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());
  final _utils = Get.put(ViewTestUtils());

  InventoryViewValidationTest({String testType}) {
    _unitTest = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _unitTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets('${_config.validation_title_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: SIZE_05_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_title_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_title_injection}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: TEXT_NUMBER_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    //DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets('${_config.validation_descript_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: SIZE_10_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_descript_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_descript_injection}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: TEXT_NUMBER_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    //PRICE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets('${_config.validation_price_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "evilLetterrr",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_price_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_price_injection}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    //URL CHECK VALIDATIONS + CHECK INJECTIONS ---------------------------------
    testWidgets('${_config.validation_url_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: URL_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_url_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_url_injection}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _unitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        _unitTest,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: URL_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);
  }

  Future<dynamic> _loadProductsInDbForThisTest(
    tester,
    bool unitTest,
  ) async {
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
    await _utils.removeCollectionFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
    await _utils.removeCollectionFromDb(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _utils.removeCollectionFromDb(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
