import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/keys/inventory_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/field_form_validation_provided.dart';

import '../../../../config/app_tests_properties.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../datasource/mocked_datasource.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import '../core/inventory_test_bindings.dart';
import 'inventory_tests.dart';

class InventoryViewValidationTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _globalUtils = Get.put(TestsGlobalUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(TestDbUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());
  final _testUtils = Get.put(TestsUtils());

  InventoryViewValidationTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <dynamic>[];

    final _tests = Get.put(InventoryTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalUtils.globalSetUpAll(
        testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE',
      );

      _products = _isWidgetTest
          ? await Future.value(MockedDatasource().products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);
    });

    tearDownAll(() => _globalUtils.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() {
      _globalUtils.globalSetUp();
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDown(_globalUtils.globalTearDown);

    //TITLE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets(_titles.validation_title_size, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: SIZE_05_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_title_empty, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_title_inject, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        validationErrorMessage: TEXT_NUMBER_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    //DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS -------------------------
    testWidgets(_titles.validation_descript_size, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "Size",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: SIZE_10_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_descript_empty, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_descript_inject, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY,
        validationErrorMessage: TEXT_NUMBER_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    //PRICE CHECK VALIDATIONS + CHECK INJECTIONS -------------------------------
    testWidgets(_titles.validation_price_size, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "evilLetterrr",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: PRICE_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_price_empty, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_price_inject, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY,
        validationErrorMessage: PRICE_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    //URL CHECK VALIDATIONS + CHECK INJECTIONS ---------------------------------
    testWidgets(_titles.validation_url_size, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "evilLetter",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: URL_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_url_empty, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: EMPTY_FIELD_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });

    testWidgets(_titles.validation_url_inject, (tester) async {
      await _tests.check_Injection_Validation(
        tester,
        inputText: "<SCRIPT>",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY,
        validationErrorMessage: URL_INVALID_ERROR_MSG,
        productToUpdate: _products.elementAt(0),
      );
    });
  }
}