import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/properties/db_urls.dart';

import '../../../../config/app_tests_properties.dart';
import '../../../../config/titles/cart_test_titles.dart';
import '../../../../datasource/mocked_datasource.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import '../../../core/bindings/cart_test_bindings.dart';
import 'cart_tests.dart';

class CartViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(TestDbUtils());
  final _titles = Get.put(CartTestTitles());
  final _bindings = Get.put(CartTestBindings());
  final _testUtils = Get.put(TestsUtils());
  final _globalUtils = Get.put(TestsGlobalUtils());
  final _mock = Get.find<MockedDatasource>();

  CartViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <dynamic>[];

    final _tests = Get.put(CartTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalUtils.globalSetUpAll(
        testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE',
      );
    });

    tearDownAll(() => _globalUtils.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() async {
      _globalUtils.globalSetUp();

      _products = _isWidgetTest
          ? await Future.value(_mock.products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest);
    });

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.view_clear_cart_clear_button, (tester) async {
      await _tests.clear_cart_tap_clear_button(tester);
    });

    testWidgets(_titles.view_add_products, (tester) async {
      await _tests.add_products_check_cartPage(tester, qtdeProducts: 2);
    });

    testWidgets(_titles.view_add_product_check_snackbar, (tester) async {
      await _tests.add_product_check_snackbar(tester, _products);
    });

    testWidgets(_titles.view_denying_dismissing_cartitem, (tester) async {
      await _tests.denying_dismissing_cartitem(tester, _products);
    });

    testWidgets(_titles.view_dismissing_first_product, (tester) async {
      await _tests.dismissing_first_added_product(tester, _products);
    });

    testWidgets(_titles.view_dismissing_all_products, (tester) async {
      await _tests.dismissing_all_added_products(tester, _products);
    });

    testWidgets(_titles.view_block_cartview_cartempty, (tester) async {
      await _tests.emptycart_block_access_to_cartpage(tester);
    });

    testWidgets(_titles.view_open_cartview, (tester) async {
      await _tests.open_cartpage_check2products(tester, _products);
    });

    testWidgets(_titles.view_check_amount_cart, (tester) async {
      await _tests.check_amount_cart(tester, _products);
    });

    testWidgets(_titles.view_order_cartProducts_tap_orderNowButton, (tester) async {
      await _tests.order_cartProducts_tap_orderNowButton(tester, _products);
    });

    testWidgets(_titles.view_backbutton, (tester) async {
      await _tests.test_page_backbutton(tester);
    });
  }
}