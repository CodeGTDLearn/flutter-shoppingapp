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

class InventoryViewValidationFunctionalTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _config = Get.put(InventoryTestConfig());

  InventoryViewValidationFunctionalTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() async => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets(_config.validation_title_size, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: SIZE_05_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_title_empty, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_title_inject, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: TEXT_NUMBER_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    //DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets(_config.validation_descript_size, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: SIZE_10_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_descript_empty, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_descript_inject, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: TEXT_NUMBER_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    //PRICE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets(_config.validation_price_size, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "evilLetterrr",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: PRICE_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_price_empty, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_price_inject, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: PRICE_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    //URL CHECK VALIDATIONS + CHECK INJECTIONS ---------------------------------
    testWidgets(_config.validation_url_size, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: URL_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_url_empty, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });

    testWidgets(_config.validation_url_inject, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.checkInputInjectionOrInputValidation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: URL_INVALID_ERROR_MSG,
        productToUpdate: product,
      );
    });
  }
}
