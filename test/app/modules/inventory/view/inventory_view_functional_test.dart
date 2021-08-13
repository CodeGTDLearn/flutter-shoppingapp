import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());

  InventoryViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <Product>[];

    final _tests = Get.put(InventoryTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() async {
      _utils.globalSetUpAll(_tests.runtimeType.toString());
      _products = await _utils.load_4ProductsInDb(isWidgetTest: _isWidgetTest);
    });

    tearDownAll(
        () => _utils.globalTearDownAll(_tests.runtimeType.toString(), _isWidgetTest));

    setUp(() {
      _bindings.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
      _utils.globalSetUp();
    });

    tearDown(_utils.globalTearDown);

    testWidgets(_titles.check_products, (tester) async {
      _isWidgetTest
          ? await _tests.check_products(tester, 4)
          : await _tests.check_products(tester, 4);
    });

    testWidgets(_titles.delete_product, (tester) async {
      await _tests.delete_product(
        tester,
        widgetsQtdeAfterDelete: 3,
        deleteButtonKey: '$INVENTORY_DELETEITEM_BUTTON_KEY${_products[3].id}',
        widgetTypetoBeDeleted: InventoryItem,
      );
    });

    testWidgets(_titles.update_product, (tester) async {
      await _tests.update_product(
        tester,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: _products[0],
      );
    });

    testWidgets(_titles.refresh_view, (tester) async {
      await _tests.refresh_view(
        tester,
        draggerWidget: _products[0],
        widgetsQtdeAfterRefresh: 2,
      );
    });

    testWidgets(_titles.tap_viewBackButton, (tester) async {
      await _tests.tap_viewBackButton(tester);
    });

    testWidgets(_titles.check_emptyView_noProductInDb, (tester) async {
      _bindings.bindingsBuilderMockedRepoEmptyDb(isWidgetTest: _isWidgetTest);
      await _tests.check_emptyView_noProductInDb(tester, DELAY);
    });
  }
}
