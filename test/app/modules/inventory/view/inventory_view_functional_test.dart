import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/inventory_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewFunctionalTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _config = Get.put(InventoryTestConfig());

  InventoryViewFunctionalTest({required String testType}) {
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
      _config.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
      _utils.globalSetUp("Starting...");
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets(_config.check_ProductsAbsence, (tester) async {
      if (!_isWidgetTest) {
        await _dbUtils.cleanDb(dbUrl: TEST_URL, dbName: DB_NAME);
      }

      _config.bindingsBuilderMockedRepoEmptyDb(isWidgetTest: _isWidgetTest);
      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    });

    testWidgets(_config.check_Products, (tester) async {
      await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      _isWidgetTest
          ? await _tests.checkInventoryItemsInInventoryView(tester, 4)
          : await _tests.checkInventoryItemsInInventoryView(tester, 2);
    });

    testWidgets(_config.delete_Product, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      await _tests.deleteInventoryProduct(
        tester,
        initialQtde: 2,
        finalQtde: 1,
        keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${product.id}',
        widgetTypeToDelete: InventoryItem,
      );
    });

    testWidgets(_config.update_Product, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      await _tests.updateInventoryProduct(
        tester,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: product,
      );
    });

    testWidgets(_config.refresh_View, (tester) async {
      var product = await _utils.loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      await _tests.refreshingInventoryView(tester, draggerWidget: product);
    });

    testWidgets(_config.view_BackButton, (tester) async {
      await _tests.tappingBackButtonInInventoryView(tester);
    });
  }
}
