import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_config.dart';
import '../../../../config/inventory_test_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewEditFunctionalTest {
  bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _config = Get.put(InventoryTestConfig());

  InventoryViewEditFunctionalTest({String testType}) {
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

    testWidgets(_config.edit_add_product_in_form, (tester) async {
      await _tests.addProductFillingFormInInventoryEditView(
        tester,
        product: ProductDataBuilder().ProductFullStaticNoId(),
        useValidTexts: true,
      );
    });

    testWidgets(_config.edit_preview_url_in_form, (tester) async {
      await _uiUtils.testInitialization(
        tester,
        isWidgetTest: _isWidgetTest,
        driver: app.AppDriver(),
      );

      await _tests.openInventoryEditView(tester);

      _utils.checkImageTotalInAView(0);
      await tester.tap(_utils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY));
      await tester.enterText(
          _utils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY), IMAGE2_TEST_URL);
      await tester.pumpAndSettle(_utils.delay(DELAY));
      await tester.tap(_utils.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY));
      await tester.pumpAndSettle(_utils.delay(DELAY));
      _utils.checkImageTotalInAView(1);
    });

    testWidgets(_config.edit_fill_form_invalid, (tester) async {
      await _tests.addProductFillingFormInInventoryEditView(
        tester,
        product: ProductDataBuilder().ProductFullStaticNoId(),
        useValidTexts: false,
      );
    });

    testWidgets(_config.edit_back_button, (tester) async {
      await _tests.tapBackButtonInInventoryEditView(tester);
    });
  }
}
