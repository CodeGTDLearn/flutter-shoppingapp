import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../config/bindings/orders_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/orders_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'orders_tests.dart';

class OrdersViewTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _titles = Get.put(OrdersTestTitles());
  final _bindings = Get.put(OrdersTestBindings());

  OrdersViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OrdersTests(
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
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(_utils.globalTearDown);

    testWidgets(_titles.orderingAProduct_inCartView_tapping_OrderNowButton,
        (tester) async {
      await _tests.orderingAProduct_inCartView_tapping_OrderNowButton(
        tester,
        DELAY,
        ordersDoneQtde: _isWidgetTest ? 2 : 1,
      );
    });

    testWidgets(_titles.check_orders_with_one_orderInDB, (tester) async {
      await _tests.create_order_from_cartView(tester, DELAY);
    });

    testWidgets(_titles.tap_viewBackButton, (tester) async {
      await _tests.tappingBackButtonInOrdersView(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    });

    testWidgets(_titles.check_emptyView_noOrderInDb, (tester) async {
      _bindings.bindingsBuilderMockRepoEmptyDb(isWidgetTest: _isWidgetTest);
      await _tests.check_emptyOrderCollection(tester, DELAY);
    });
  }
}
