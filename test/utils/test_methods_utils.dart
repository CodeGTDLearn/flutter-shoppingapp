import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../config/tests_properties.dart';
import '../data_builders/product_databuilder.dart';
import '../mocked_datasource/mocked_datasource.dart';
import 'db_test_utils.dart';

class TestMethodsUtils {
  void checkImageTotalInAView(int numberOfImages) {
    mockNetworkImagesFor(() async {
      expect(find.byType(Image), findsNWidgets(numberOfImages));
    });
  }

  Future<Product> load_2Products_InDb({
    required bool isWidgetTest,
  }) async {
    var _product;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      await Future.delayed(delay(DELAY));
      await dbTestUtils
          .add_sameObject_multipleTimes(
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductWithoutId(),
              interval: DELAY)
          .then((value) => _product = value[0]);
    }
    Get.delete(tag: 'dbInstance');
    return isWidgetTest
        ? Future.value(MockedDatasource().products()[0])
        : Future.value(_product);
  }

  Future<List<Product>> load_ProductList_InDb({
    required bool isWidgetTest,
    required int totalProducts,
  }) async {
    var _onlineTestDb_products_datasource;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      await Future.delayed(delay(DELAY));
      await dbTestUtils
          .add_objectList(
            collectionUrl: PRODUCTS_URL,
            objectList: productList_for_onlineTestDb(totalProducts),
          )
          .then((value) => _onlineTestDb_products_datasource = value);
    }
    Get.delete(tag: 'dbInstance');
    return isWidgetTest
        ? Future.value(MockedDatasource().products())
        : Future.value(_onlineTestDb_products_datasource.cast<Product>());
  }

  void checkCollectionSize({
    required bool isWidgetTest,
    required String collectionUrl,
    required int totalItems,
  }) async {
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      var items = await dbTestUtils.countCollectionItems(collectionUrl: collectionUrl);
      expect(items, totalItems);
    }
    Get.delete(tag: 'dbInstance');
  }

  List<Object> productList_for_onlineTestDb(int totalItems) {
    var listObject = <Object>[];
    for (var i = 0; i < totalItems; i++) {
      listObject.add(ProductDataBuilder().ProductWithoutId_imageMap());
    }
    return listObject;
  }

  Duration delay(int seconds) {
    return Duration(seconds: seconds);
  }
}
