import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/test_global_methods.dart';
import '../../../../utils/test_methods_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewEditTest {
  late bool _isWidgetTest;
  final _globalMethods = Get.put(TestGlobalMethods());
  final _testUtils = Get.put(TestMethodsUtils());
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
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

    setUpAll(() async => _globalMethods
        .globalSetUpAll('${_tests.runtimeType.toString()} $SHARED_STATE_TITLE'));

    tearDownAll(() =>
        _globalMethods.globalTearDownAll(_tests.runtimeType.toString(), _isWidgetTest));

    setUp(() {
      _globalMethods.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.edit_add_product_in_form, (tester) async {
      await _tests.edit_add_product_in_form(
        tester,
        product: ProductDataBuilder().ProductWithoutId(),
        useValidTexts: true,
      );
    });

    testWidgets(_titles.test_auto_currency_in_form, (tester) async {
      await _tests.test_auto_currency_in_form(
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
      // mockNetworkImagesFor(() => tester.pumpWidget(makeTestableWidget()));
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
