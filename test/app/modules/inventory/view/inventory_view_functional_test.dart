import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewFunctionalTest {
  bool _isUnitTest;
  final bool _skipTest = false;

  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());
  final _utils = Get.put(ViewTestUtils());

  InventoryViewFunctionalTest({String testType}) {
    _isUnitTest = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _isUnitTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets('${_config.checking_ProductsAbsence}', (tester) async {
      if (_isUnitTest == false) await _cleanDb(tester);
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _isUnitTest);
      await _tests.checkInventoryProductsAbsence(tester, DELAY, _isUnitTest);
    }, skip: _skipTest);

    testWidgets('${_config.checking_Products}', (tester) async {
      if (!_isUnitTest) {
        await _cleanDb(tester);
        await _utils.addObjectsInDb(tester,
            qtdeObjects: 2,
            collectionUrl: PRODUCTS_URL,
            object: ProductDataBuilder().ProductFullStaticNoId(),
            delaySeconds: DELAY);
      }

      _isUnitTest
          ? await _tests.checkInventoryProducts(tester, 4, _isUnitTest)
          : await _tests.checkInventoryProducts(tester, 2, _isUnitTest);
    }, skip: _skipTest);

    testWidgets('${_config.deleting_Product}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.deleteInventoryProduct(
        tester,
        _isUnitTest,
        initialQtde: 2,
        finalQtde: 1,
        keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${product.id}',
        widgetTypeToDelete: InventoryItem,
      );
    }, skip: _skipTest);

    testWidgets('${_config.updating_Product}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.updateInventoryProduct(
        tester,
        _isUnitTest,
        inputValidText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.refreshingInventoryView}', (tester) async {
      var product = await _loadProductsInDbForThisTest(tester, _isUnitTest);

      await _tests.refreshingInventoryView(
        tester,
        _isUnitTest,
        trigger: product,
      );
    }, skip: _skipTest);

    testWidgets('${_config.testInventoryViewBackButton}', (tester) async {
      await _tests.tapingBackButtonInInventoryView(
        tester,
        _isUnitTest,
      );
    }, skip: _skipTest);
  }

  Future<dynamic> _loadProductsInDbForThisTest(
    tester,
    bool isUnitTest,
  ) async {
    var _product;

    if (!isUnitTest) {
      await _cleanDb(tester);
      await _utils
          .addObjectsInDb(tester,
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY)
          .then((value) => _product = value[0]);
    }

    return isUnitTest ? ProductsMockedDatasource().products()[0] : _product;
  }

  Future _cleanDb(tester) async {
    await _utils.removeCollectionFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
    await _utils.removeCollectionFromDb(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _utils.removeCollectionFromDb(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
