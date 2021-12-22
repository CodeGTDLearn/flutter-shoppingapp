import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../config/tests_properties.dart';
import '../data_builders/product_databuilder.dart';
import '../datasource/mocked_datasource.dart';
import 'testdb_utils.dart';

class TestsUtils {
  void checkImageTotalInAView(int numberOfImages) {
    mockNetworkImagesFor(() async {
      expect(find.byType(Image), findsNWidgets(numberOfImages));
    });
  }

  Future<Product> post_2databuilderProducts_InDb({
    required bool isWidgetTest,
  }) async {
    var _product;
    var dbTestUtils = Get.put(TestDbUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(url: TESTDB_ROOT_URL, dbName: TESTDB_NAME);
      await Future.delayed(delay(DELAY));
      await dbTestUtils
          .add_product_multipleTimes(
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

  Future<List<Product>> post_databuilderProductList_InDb({
    required bool isWidgetTest,
    required int numberOfProducts,
  }) async {
    var totalProducts = numberOfProducts < 2 ? 2 : numberOfProducts;
    var _onlineTestDb_products_datasource;
    var dbTestUtils = Get.put(TestDbUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(url: TESTDB_ROOT_URL, dbName: TESTDB_NAME);
      await Future.delayed(delay(DELAY));
      await dbTestUtils
          .add_productList(
            collectionUrl: PRODUCTS_URL,
            objectList: generate_databuilder_listItems(totalProducts),
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
    required String url,
    required int totalItems,
  }) async {
    var dbTestUtils = Get.put(TestDbUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      var items = await dbTestUtils.countCollectionItems(url: url);
      expect(items, totalItems);
    }
    Get.delete(tag: 'dbInstance');
  }

  List<Object> generate_databuilder_listItems(int totalItems) {
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