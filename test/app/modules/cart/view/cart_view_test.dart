import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../../../config/bindings/cart_test_bindings.dart';
import '../../../../config/tests_properties.dart';
import '../../../../config/titles/cart_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/test_global_methods.dart';
import '../../../../utils/test_methods_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'cart_tests.dart';

class CartViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _titles = Get.put(CartTestTitles());
  final _bindings = Get.put(CartTestBindings());
  final _globalMethods = Get.put(TestGlobalMethods());
  final _testUtils = Get.put(TestMethodsUtils());

  CartViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <Product>[];

    final _tests = Get.put(CartTests(
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
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(_globalMethods.globalTearDown);

    List<Product> _prods() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    double totalCart() {
      return Get.find<CartController>().getAmountCartItemsObs();
    }

    testWidgets(_titles.add_product_check_appbar_shopCart, (tester) async {
      await _tests.Add2Products_checkAppbarCartIconQtde(tester);
    });

    testWidgets(_titles.add_product_check_cartPage, (tester) async {
      await _tests.AddProductCheckProductInCartPage(tester, _products);
    });

    testWidgets(_titles.add_product_check_snackbar, (tester) async {
      await _tests.AddProductCheckSnackbarInfo(tester, _prods);
    });

    // testWidgets(_titles.deny_first_product_dismissing, (tester) async {
    //   await _tests.DenyingFirstProductDismissing(tester, _prods);
    // });

    // testWidgets(_titles.dismissing_first_product_added, (tester) async {
    //   await _tests.DismissingFirstAddedProduct(tester, _prods);
    // });
    //
    // testWidgets(_titles.dismissing_second_last_product_added, (tester) async {
    //   await _tests.DismissingSecondLastAddedProduct(tester, _prods);
    // });
    //
    // testWidgets(_titles.no_products_no_access_cartPage, (tester) async {
    //   await _tests.NoProductsInTheCartNoAccessCartPage(tester);
    // });
    //
    // testWidgets(_titles.test_2_products_in_cartPage, (tester) async {
    //   await _tests.AccessingCartPageTestingTwoAddedProducts(tester, _prods);
    // });
    //
    // testWidgets(_titles.check_amount_cart, (tester) async {
    //   await _tests.CheckAmountCart(tester, _prods);
    // });
    //
    // testWidgets(_titles.order_cart_products_order_now_button, (tester) async {
    //   await _tests.OrderCartProductsOrderNowButton(tester, _prods, totalCart);
    // });
    //
    // testWidgets(_titles.clear_cart_products, (tester) async {
    //   await _tests.ClearCartProductsClearButton(tester, _prods, totalCart);
    // });
    //
    // testWidgets(_titles.test_page_backbutton, (tester) async {
    //   await _tests.TestingPageBackButton(tester);
    // });
  }
}
