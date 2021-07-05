import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/inventory_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewValidationTest {
  bool _isWidgetTest;
  final _skipTest = false;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _config = Get.put(InventoryTestConfig());

  InventoryViewValidationTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() async {
      _utils.globalSetUpAll(_tests.runtimeType.toString());
      await _dbUtils.cleanDb(url: TEST_URL, interval: DELAY, db: DB_NAME);
    });

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets('${_config.validation_title_size}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: SIZE_05_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_title_empty}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_title_inject}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

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
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: SIZE_10_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_descript_empty}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_descript_inject}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

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
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "evilLetterrr",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: PRICE_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_price_empty}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_price_inject}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

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
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: URL_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_url_empty}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: EMPTY_FIELD_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.validation_url_inject}', (tester) async {
      var product = await _tests.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        injectionTextOrInvalidText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        shownValidationErrorMessage: URL_INVALID_MSG,
        productToUpdate: product,
      );
    }, skip: _skipTest);
  }
}
