import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../config/tests_config.dart';
import '../data_builders/product_databuilder.dart';
import '../mocked_datasource/mocked_products_datasource.dart';
import 'db_test_utils.dart';

class TestUtils {
  Finder key(String keyText) {
    return find.byKey(Key(keyText));
  }

  Finder text(String text) {
    return find.text(text);
  }

  Finder iconType(Type widgetType, IconData iconData) {
    return find.widgetWithIcon(widgetType, iconData);
  }

  Finder type(Type widgetType) {
    return find.byType(widgetType);
  }

  Finder iconData(IconData iconData) {
    return find.byIcon(iconData);
  }

  Finder icon(Icon icon) {
    return find.byWidgetPredicate((widget) => widget is Icon && widget.icon == icon.icon);
  }

  Duration delay(int seconds) {
    return Duration(seconds: seconds);
  }

  //todo null-safety - https://pub.dev/packages/network_image_mock
  void checkImageTotalInAView(int numberOfImages) {
    // provideMockedNetworkImages(() async {
    //   expect(find.byType(Image), findsNWidgets(numberOfImages));
    // });
  }

  Future<Product> load_2Products_InDb({
    required bool isWidgetTest,
  }) async {
    var _product;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    var testUtils = Get.put(TestUtils(), tag: 'testUtilsInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      await Future.delayed(testUtils.delay(DELAY));
      await dbTestUtils
          .add_sameObject_multipleTimes_inDb(
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductWithoutId(),
              interval: DELAY)
          .then((value) => _product = value[0]);
    }
    Get.delete(tag: 'dbInstance');
    Get.delete(tag: 'testUtilsInstance');
    return isWidgetTest
        ? Future.value(MockedProductsDatasource().products()[0])
        : Future.value(_product);
  }

  Future<List<Product>> load_4Products_InDb({required bool isWidgetTest}) async {
    var _listProducts;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    var testUtils = Get.put(TestUtils(), tag: 'testUtilsInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      await Future.delayed(testUtils.delay(DELAY));
      await dbTestUtils.add_objectList_inDb(
        collectionUrl: PRODUCTS_URL,
        objectList: [
          ProductDataBuilder().ProductWithoutIdCustomUrlImage(position_From1_To4: 1),
          ProductDataBuilder().ProductWithoutIdCustomUrlImage(position_From1_To4: 2),
          ProductDataBuilder().ProductWithoutIdCustomUrlImage(position_From1_To4: 3),
          ProductDataBuilder().ProductWithoutIdCustomUrlImage(position_From1_To4: 4),
        ],
      ).then((value) => _listProducts = value);
    }
    Get.delete(tag: 'dbInstance');
    Get.delete(tag: 'testUtilsInstance');
    return isWidgetTest
        ? Future.value(MockedProductsDatasource().products())
        : Future.value(_listProducts.cast<Product>());
  }

  Future<List<Product>> load_1Product_InDb({required bool isWidgetTest}) async {
    var _listProducts;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    var testUtils = Get.put(TestUtils(), tag: 'testUtilsInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      await Future.delayed(testUtils.delay(DELAY));
      await dbTestUtils.add_objectList_inDb(
        collectionUrl: PRODUCTS_URL,
        objectList: [ProductDataBuilder().ProductWithoutId()],
      ).then((value) => _listProducts = value);
    }
    Get.delete(tag: 'dbInstance');
    Get.delete(tag: 'testUtilsInstance');
    return isWidgetTest
        ? Future.value(MockedProductsDatasource().products())
        : Future.value(_listProducts.cast<Product>());
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

  void globalSetUpAll(String testModuleName) async {
    print(_headerGenerator(
      module: testModuleName,
      label: 'Starting FunctionalTests: ',
      fullLength: 73,
      qtdeSuperiorLine: 2,
      lineCharacter: '=',
    ));
  }

  void globalTearDownAll(String testModuleName, bool isWidgetTest) async {
    print('\n'
        '<<=============================================================<<\n'
        '<<=============================================================<<\n'
        '<<==<< FunctionalTests Finished: $testModuleName \n'
        '<<=============================================================<<\n'
        '<<=============================================================<<\n'
        '\n \n \n');

    if (!isWidgetTest) {
      var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      Get.delete(tag: 'dbInstance');
    }

    Get.reset;
  }

  void globalSetUp() {
    var label = "Test Starting...";
    print('\n'
        '>---------------------------------------------------------------------------'
        '----------------->\n'
        '>----------------->    $label >----------------->\n');
  }

  void globalTearDown() {
    var label = "...Test Finished";
    print('\n'
        '<-----------------< $label    <-----------------<\n'
        '<----------------------------------------------------------------------------'
        '----------------<'
        '\n\n\n');
    Get.reset;
  }

  String _headerGenerator({
    required String module,
    required String label,
    required String lineCharacter,
    required int fullLength,
    required int qtdeSuperiorLine,
  }) {
    var title = '$label $module';
    var arrowChar = '>';
    var superiorLine = arrowChar;
    var middleLine = arrowChar;
    for (var i = 0; i < fullLength; i++) {
      superiorLine = "$superiorLine=";
    }

    superiorLine = '$superiorLine$arrowChar\n';
    var middleLength = fullLength / 8;

    for (var i = 0; i < middleLength.toInt(); i++) {
      middleLine = "$middleLine$lineCharacter";
    }
    middleLine = middleLine + arrowChar;

    for (var i = 1; i < qtdeSuperiorLine; i++) {
      superiorLine = "$superiorLine${"$superiorLine"}";
    }
    // var middle = '$middleLine $title $middleLine';
    var middle = '$middleLine $title';
    var footer = '\n$superiorLine\n \n';

    return '$superiorLine$middle$footer';
  }
}
