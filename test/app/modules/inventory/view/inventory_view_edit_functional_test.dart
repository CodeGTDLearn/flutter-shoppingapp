import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_edit_view.dart';
import 'package:shopingapp/app_driver.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/db_test_utils.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/ui_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewEditFunctionalTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final TestUtils _utils = Get.put(TestUtils());
  final UiTestUtils _uiUtils = Get.put(UiTestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());
  final InventoryTestConfig _config = Get.put(InventoryTestConfig());

  InventoryViewEditFunctionalTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryViewTests(
        isWidgetTest: _isWidgetTest,
        testUtils: _utils,
        uiTestUtils: _uiUtils,
        dbTestUtils: _dbUtils));

    setUpAll(() => _uiUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _uiUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _uiUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
      // _utils = Get.put(TestUtils());
    });

    tearDown(() => _uiUtils.globalTearDown("...Ending"));

    testWidgets('${_config.edit_add_product_in_form}', (tester) async {
      await _tests.addProductFillingFormInInventoryEditView(
        tester,
        product: ProductDataBuilder().ProductFullStaticNoId(),
        useValidTexts: true,
      );
    }, skip: _skipTest);

    testWidgets('${_config.edit_preview_url_in_form}', (tester) async {
      await _uiUtils.testInitialization(
        tester,
        isWidgetTest: _isWidgetTest,
        appDriver: app.AppDriver(),
      );

      await _tests.openInventoryEditView(tester);

      _utils.checkImageTotalOnAView(0);
      await tester.tap(_utils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY));
      await tester.enterText(
          _utils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY), IMAGE2_TEST_URL);
      await tester.pumpAndSettle(_utils.delay(DELAY));
      await tester.tap(_utils.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY));
      await tester.pumpAndSettle(_utils.delay(DELAY));
      _utils.checkImageTotalOnAView(1);
    }, skip: _skipTest);

    testWidgets('${_config.edit_fill_form_invalid}', (tester) async {
      await _tests.addProductFillingFormInInventoryEditView(
        tester,
        product: ProductDataBuilder().ProductFullStaticNoId(),
        useValidTexts: false,
      );
    }, skip: _skipTest);

    testWidgets('${_config.edit_back_button}', (tester) async {
      await _tests.tapBackButtonInInventoryEditView(tester);
    }, skip: _skipTest);
  }
}
