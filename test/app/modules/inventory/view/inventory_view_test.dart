import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/properties/db_urls.dart';
import 'package:shopingapp/app/modules/inventory/core/components/custom_listtile/simple_listtile.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';

import '../../../../config/app_tests_properties.dart';
import '../../../../config/datasource/mocked_datasource.dart';
import '../../../../config/utils/finder_utils.dart';
import '../../../../config/utils/testdb_utils.dart';
import '../../../../config/utils/tests_global_utils.dart';
import '../../../../config/utils/tests_utils.dart';
import '../../../../config/utils/ui_test_utils.dart';
import '../core/inventory_test_bindings.dart';
import '../core/inventory_test_titles.dart';
import 'inventory_tests.dart';

class InventoryViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(TestDbUtils());
  final _bindings = Get.put(InventoryTestBindings());
  final _titles = Get.put(InventoryTestTitles());
  final _globalUtils = Get.put(TestsGlobalUtils());
  final _testUtils = Get.put(TestsUtils());
  final _keysInv = Get.put(InventoryKeys());

  InventoryViewTest({required String testType}) {
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
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
      _globalUtils.globalSetUp();
    });

    tearDown(_globalUtils.globalTearDown);

    testWidgets(
      _titles.check_products,
      (tester) async {
        await _tests.check_qtde_products(tester, _products.length);
      },
    );

    testWidgets(
      _titles.update_product,
      (tester) async {
        await _tests.update_product(
          tester,
          inputValidText: "XXXXXX",
          fieldKey: _keysInv.k_inv_edit_fld_title(),
          productToUpdate: _products.elementAt(0),
        );
      },
    );

    testWidgets(
      _titles.delete_product,
      (tester) async {
        await _tests.delete_product(
          tester,
          deleteButtonKey:
              '${_keysInv.k_inv_del_btn}${_products[_products.length - 1].id}',
          widgetTypetoBeDeleted: SimpleListTile,
          qtdeAfterDelete: _products.length - 1,
        );
      },
    );

    testWidgets(
      _titles.refresh_view,
      (tester) async {
        await _tests.refresh_view(
          tester,
          draggerWidget: _products.elementAt(0),
          //a) delete above; b) deleted from DB manually
          qtdeAfterRefresh: _products.length - 2,
        );
      },
    );

    testWidgets(
      _titles.tap_viewBackButton,
      (tester) async {
        await _tests.tap_viewBackButton(tester);
      },
    );

    testWidgets(
      _titles.check_emptyView_noProductInDb,
      (tester) async {
        _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: true);
        await _tests.check_emptyView_noProductInDb(tester, DELAY);
      },
    );
  }
}