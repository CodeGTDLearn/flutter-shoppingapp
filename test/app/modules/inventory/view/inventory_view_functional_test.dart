import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/inventory_test_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'inventory_tests.dart';

class InventoryViewFunctionalTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final TestUtils _utils = Get.put(TestUtils());
  final UiTestUtils _uiUtils = Get.put(UiTestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());
  final InventoryTestConfig _config = Get.put(InventoryTestConfig());

  InventoryViewFunctionalTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryTests(
        isWidgetTest: _isWidgetTest,
        testUtils: _utils,
        uiTestUtils: _uiUtils,
        dbTestUtils: _dbUtils));

    setUpAll(() => _uiUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _uiUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _uiUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isUnitTest: _isWidgetTest);
    });

    tearDown(() => _uiUtils.globalTearDown("...Ending"));

    testWidgets('${_config.check_ProductsAbsence}', (tester) async {
      if (!_isWidgetTest) {
        await _dbUtils.removeAllCollections(tester, delaySeconds: DELAY, dbName: DB_NAME);
      }
      _config.bindingsBuilderMockedRepoEmptyDb(isWidgetTest: _isWidgetTest);
      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    }, skip: _skipTest);

    testWidgets('${_config.check_Products}', (tester) async {
      await _loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      _isWidgetTest
          ? await _tests.checkInventoryViewProducts(tester, 4)
          : await _tests.checkInventoryViewProducts(tester, 2);
    }, skip: _skipTest);

    testWidgets('${_config.delete_Product}', (tester) async {
      var product = await _loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      await _tests.deleteInventoryProduct(
        tester,
        initialQtde: 2,
        finalQtde: 1,
        keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${product.id}',
        widgetTypeToDelete: InventoryItem,
      );
    }, skip: _skipTest);

    testWidgets('${_config.update_Product}', (tester) async {
      var product = await _loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);

      await _tests.updateInventoryProduct(
        tester,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.refresh_View}', (tester) async {
      var product = await _loadTwoProductsInDb(tester, isWidgetTest: _isWidgetTest);
      await _tests.refreshingInventoryView(tester, triggerProduct: product);
    }, skip: _skipTest);

    testWidgets('${_config.test_ViewBackButton}', (tester) async {
      await _tests.tapingBackButtonInInventoryView(tester);
    }, skip: _skipTest);
  }

  Future<dynamic> _loadTwoProductsInDb(tester, {bool isWidgetTest}) async {
    var _product;

    if (!isWidgetTest) {
      await _dbUtils.removeAllCollections(tester, delaySeconds: DELAY, dbName: DB_NAME);
      await _dbUtils
          .addMultipleObjects(tester,
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY)
          .then((value) => _product = value[0]);
    }
    return isWidgetTest ? ProductsMockedDatasource().products()[0] : _product;
  }
}
