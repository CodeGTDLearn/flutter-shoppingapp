import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewEditTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());

  InventoryViewEditTest({required String testType}) {
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

    tearDownAll(
        () => _utils.globalTearDownAll(_tests.runtimeType.toString(), _isWidgetTest));

    setUp(() {
      _utils.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(_utils.globalTearDown);

    testWidgets(_titles.edit_add_product_in_form, (tester) async {
      await _tests.edit_add_product_in_form(
        tester,
        product: ProductDataBuilder().ProductWithoutId(),
        useValidTexts: true,
      );
    });

    testWidgets(_titles.edit_preview_url_in_form, (tester) async {
      await _uiUtils.testInitialization(
        tester,
        isWidgetTest: _isWidgetTest,
        appDriver: app.AppDriver(),
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

    testWidgets(_titles.edit_fill_form_with_invalid_content, (tester) async {
      await _tests.edit_add_product_in_form(
        tester,
        product: ProductDataBuilder().ProductWithoutId(),
        useValidTexts: false,
      );
    });

    testWidgets(_titles.edit_back_button, (tester) async {
      await _tests.edit_back_button(tester);
    });
  }
}
