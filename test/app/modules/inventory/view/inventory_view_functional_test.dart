import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewFunctionalTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final _config = Get.put(InventoryTestConfig());
  final _viewUtils = Get.put(ViewTestUtils());
  final _testUtils = Get.put(TestUtils());

  InventoryViewFunctionalTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryViewTests(
      testType: _isWidgetTest,
      testUtils: _testUtils,
      viewTestUtils: _viewUtils,
    ));

    setUpAll(() => _viewUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _viewUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _viewUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(testType: _isWidgetTest);
    });

    tearDown(() => _viewUtils.globalTearDown("...Ending"));

    testWidgets('${_config.check_ProductsAbsence}', (tester) async {
      if (_isWidgetTest == false) await _cleanDb(tester);

      _config.bindingsBuilderMockedRepoEmptyDb(testType: _isWidgetTest);

      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    }, skip: _skipTest);

    testWidgets('${_config.check_Products}', (tester) async {
      await _loadTwoProductsInDb(tester, testType: _isWidgetTest);

      _isWidgetTest
          ? await _tests.checkInventoryViewProducts(tester, 4)
          : await _tests.checkInventoryViewProducts(tester, 2);
    }, skip: _skipTest);

    testWidgets('${_config.delete_Product}', (tester) async {
      var product = await _loadTwoProductsInDb(tester, testType: _isWidgetTest);

      await _tests.deleteInventoryProduct(
        tester,
        initialQtde: 2,
        finalQtde: 1,
        keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${product.id}',
        widgetTypeToDelete: InventoryItem,
      );
    }, skip: _skipTest);

    testWidgets('${_config.update_Product}', (tester) async {
      var product = await _loadTwoProductsInDb(tester, testType: _isWidgetTest);

      await _tests.updateInventoryProduct(
        tester,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: product,
      );

    }, skip: _skipTest);

    testWidgets('${_config.refresh_inventoryView}', (tester) async {
      var product = await _loadTwoProductsInDb(tester, testType: _isWidgetTest);

      await _tests.refreshingInventoryView(tester, trigger: product);

    }, skip: _skipTest);

    testWidgets('${_config.testInventoryViewBackButton}', (tester) async {

      await _tests.tapingBackButtonInInventoryView(tester);

    }, skip: _skipTest);
  }

  Future<dynamic> _loadTwoProductsInDb(tester, {bool testType}) async {
    var _product;

    if (!testType) {
      await _cleanDb(tester);
      await _viewUtils
          .addObjectsInDb(tester,
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY)
          .then((value) => _product = value[0]);
    }
    return testType ? ProductsMockedDatasource().products()[0] : _product;
  }

  Future _cleanDb(tester) async {
    await _viewUtils.removeCollectionFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
    await _viewUtils.removeCollectionFromDb(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _viewUtils.removeCollectionFromDb(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
