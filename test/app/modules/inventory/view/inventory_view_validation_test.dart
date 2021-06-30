import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/db_test_utils.dart';
import '../../../../test_utils/ui_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewValidationTest {
  bool _isUnitTest;
  final bool _skipTest = false;
  final _uiTestUtils = Get.put(UiTestUtils());
  final _dbTestUtils = Get.put(DbTestUtils());
  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());

  InventoryViewValidationTest({String testType}) {
    _isUnitTest = testType == WIDGET_TEST;
  }

  void functional() {
    setUpAll(() => _uiTestUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _uiTestUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _uiTestUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isUnitTest: _isUnitTest);
    });

    tearDown(() => _uiTestUtils.globalTearDown("...Ending"));

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets('${_config.validation_title_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: SIZE_05_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_title_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_title_inject}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: TEXT_NUMBER_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    //DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets('${_config.validation_descript_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: SIZE_10_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_descript_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_descript_inject}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: TEXT_NUMBER_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    //PRICE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets('${_config.validation_price_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "evilLetterrr",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_price_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_price_inject}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    //URL CHECK VALIDATIONS + CHECK INJECTIONS ---------------------------------
    testWidgets('${_config.validation_url_size}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: URL_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_url_empty}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_url_inject}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
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
      await _dbTestUtils
          .addMultipleObjects(tester,
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY)
          .then((value) => _product = value[0]);
    }

    return unitTest ? ProductsMockedDatasource().products()[0] : _product;
  }

  Future _cleanDb(tester) async {
    await _dbTestUtils.removeCollection(tester, url: ORDERS_URL, delaySeconds: 1);
    await _dbTestUtils.removeCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _dbTestUtils.removeCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
