import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/keys/inventory_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import '../core/inventory_test_bindings.dart';
import 'inventory_tests.dart';

class InventoryViewEditTest {
  late bool _isWidgetTest;
  final _globalUtils = Get.put(TestsGlobalUtils());
  final _testUtils = Get.put(TestsUtils());
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(TestDbUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());

  InventoryViewEditTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(
          () async => _globalUtils.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE'),
    );

    tearDownAll(() => _globalUtils.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() {
      _globalUtils.globalSetUp();
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.add_product_in_edit_form, (tester) async {
      await _tests.add_product_using_edit_form(
        tester,
        product: ProductDataBuilder().ProductWithoutId_imageMap(),
        useValidTexts: true,
      );
    });

    testWidgets(_titles.test_auto_currency_in_form, (tester) async {
      await _tests.test_auto_currency_in_form(
        tester,
        product: ProductDataBuilder().ProductWithoutId_imageMap(),
        useValidTexts: true,
      );
    });

    testWidgets(_titles.edit_preview_url_in_form, (tester) async {
      await _uiUtils.testInitialization(
        tester,
        isWidgetTest: _isWidgetTest,
        appDriver: app.AppDriver(),
        applyDelay: true,
      );

      await _tests.openInventoryEditView(tester);

      _testUtils.checkImageTotalInAView(0);
      await tester.tap(_finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY));
      await tester.enterText(
        _finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
        TEST_IMAGE_URL_MAP.values.elementAt(1),
      );
      await tester.pumpAndSettle(_testUtils.delay(DELAY));
      await tester.tap(_finder.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY));
      await tester.pumpAndSettle(_testUtils.delay(DELAY));
      _testUtils.checkImageTotalInAView(1);
    });

    testWidgets(_titles.edit_fill_form_with_invalid_content, (tester) async {
      await _tests.add_product_using_edit_form(
        tester,
        product: ProductDataBuilder().ProductWithoutId_imageMap(),
        useValidTexts: false,
      );
    });

    testWidgets(_titles.edit_back_button, (tester) async {
      await _tests.edit_back_button(tester);
    });
  }
}