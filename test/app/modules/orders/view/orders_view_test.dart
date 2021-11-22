import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../config/tests_properties.dart';
import '../../../../config/titles/orders_test_titles.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import '../core/orders_test_bindings.dart';
import 'orders_tests.dart';

class OrdersViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(TestDbUtils());
  final _titles = Get.put(OrdersTestTitles());
  final _bindings = Get.put(OrdersTestBindings());
  final _globalUtils = Get.put(TestsGlobalUtils());
  final _testUtils = Get.put(TestsUtils());

  OrdersViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OrdersTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async => _globalUtils.globalSetUpAll(
        testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE'));

    tearDownAll(() => _globalUtils.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() {
      _globalUtils.globalSetUp();
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.orderProduct_using_cartView_tapping_orderNowButton,
        (tester) async {
      await _tests.orderProduct_using_cartView_tapping_orderNowButton(
        tester,
        DELAY,
        ordersDoneQtde: _isWidgetTest ? 2 : 1,
      );
    });

    testWidgets(_titles.check_orders_with_one_orderInDB, (tester) async {
      await _tests.create_order_from_cartView(tester, DELAY);
    });

    testWidgets(_titles.test_page_backbutton, (tester) async {
      await _tests.test_page_backbutton(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    });

    testWidgets(_titles.check_emptyView_noOrderInDb, (tester) async {
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: true);
      await _tests.check_emptyView_noOrderInDb(tester, DELAY);
    });
  }
}