import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../config/tests_properties.dart';
import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/test_global_methods.dart';
import '../../../../utils/test_methods_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());
  final _globalMethods = Get.put(TestGlobalMethods());
  final _testUtils = Get.put(TestMethodsUtils());

  InventoryViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <Product>[];

    final _tests = Get.put(InventoryTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalMethods
          .globalSetUpAll('${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');
      _products = await _testUtils.load_ProductList_InDb(
        isWidgetTest: _isWidgetTest,
        totalProducts: 6,
      );
    });

    tearDownAll(() =>
        _globalMethods.globalTearDownAll(_tests.runtimeType.toString(), _isWidgetTest));

    setUp(() {
      _globalMethods.globalSetUp();
      _bindings.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.check_products, (tester) async {
      await _tests.check_products(tester, _products.length);
    });

    testWidgets(_titles.delete_product, (tester) async {
      await _tests.delete_product(
        tester,
        deleteButtonKey: '$INVENTORY_DELETEITEM_BUTTON_KEY${_products[3].id}',
        widgetTypetoBeDeleted: InventoryItem,
        qtdeAfterDelete: _products.length - 1,
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
        qtdeAfterRefresh: _products.length - 2,
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
