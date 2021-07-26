import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../config/app_tests_config.dart';
import '../data_builders/product_databuilder.dart';
import '../test_datasource/test_products_datasource.dart';
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

  //todo null-safety - resolver o problema do package: image_test_utils: 1.0.0
  void checkImageTotalInAView(int numberOfImages) {
    // provideMockedNetworkImages(() async {
    //   expect(find.byType(Image), findsNWidgets(numberOfImages));
    // });
  }

  Future<Product> loadTwoProductsInDb(tester, {required bool isWidgetTest}) async {
    var _product;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TEST_URL, dbName: DB_NAME);
      await dbTestUtils
          .addMultipleObjects(
            tester,
            qtdeObjects: 2,
            collectionUrl: PRODUCTS_URL,
            object: ProductDataBuilder().ProductFullStaticNoId(),
            interval: DELAY,
          )
          .then((value) => _product = value[0]);
    }
    Get.delete(tag: 'dbInstance');
    return isWidgetTest
        ? Future.value(TestProductsDatasource().products()[0])
        : Future.value(_product);
  }

  Future<List<Product>> loadFourProductsListInDb(
    tester, {
    required bool isWidgetTest,
  }) async {
    var _listProducts;
    var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    if (!isWidgetTest) {
      await dbTestUtils.cleanDb(dbUrl: TEST_URL, dbName: DB_NAME);
      await dbTestUtils
          .addMultipleObjects(
            tester,
            qtdeObjects: 4,
            collectionUrl: PRODUCTS_URL,
            object: ProductDataBuilder().ProductFullStaticNoId(),
            interval: DELAY,
          )
          .then((value) => _listProducts = value);
    }
    Get.delete(tag: 'dbInstance');
    return isWidgetTest
        ? Future.value(TestProductsDatasource().products())
        : Future.value(_listProducts.cast<Product>());
  }

  void globalSetUpAll(String testModuleName) async {
    print(_headerGenerator(
      module: testModuleName,
      label: 'Starting FunctionalTests: ',
      fullLength: 63,
      arrowChar: '>',
      qtdeSuperiorLine: 2,
      lineCharacter: '=',
    ));

    await Get.put(DbTestUtils()).cleanDb(dbUrl: TEST_URL, dbName: DB_NAME);
  }

  void globalTearDownAll(String testModuleName) async {
    print('\n'
        '<<=============================================================<<\n'
        '<<=============================================================<<\n'
        '<========<< Concluding FunctionalTests: $testModuleName \n'
        '<<=============================================================<<\n'
        '<<=============================================================<<\n'
        '\n \n \n');
    Get.reset;
  }

  void globalSetUp(String testModuleName) {
    print(''
        '>--------------------------------------------------------------->\n'
        '>---------> $testModuleName >---------> \n \n');
    // '>---------> Test: $testModuleName >---------> \n \n');
  }

  void globalTearDown(String testModuleName) {
    print('\n \n'
        // '<---------< Test: $testModuleName <---------< \n'
        '<---------< $testModuleName <---------< \n'
        '<---------------------------------------------------------------<'
        '\n \n \n');
    Get.reset;
  }

  String _headerGenerator({
    required String module,
    required String label,
    required String arrowChar,
    required String lineCharacter,
    required int fullLength,
    required int qtdeSuperiorLine,
  }) {
    var title = '$label $module';
    var superiorLine = arrowChar;
    var middleLine = arrowChar;
    for (var i = 0; i < fullLength; i++) {
      superiorLine = "$superiorLine=";
    }

    superiorLine = '$superiorLine$arrowChar\n';
    // var middleLength = (superiorLine.length - title.length) / 3;
    var middleLength = fullLength / 8;

    for (var i = 0; i < middleLength.toInt(); i++) {
      middleLine = "$middleLine$lineCharacter";
    }
    middleLine = middleLine + arrowChar;

    for (var i = 1; i < qtdeSuperiorLine; i++) {
      superiorLine = "$superiorLine${"$superiorLine"}";
    }
    var middle = '$middleLine $title $middleLine';
    // var footer = '\n$superiorLine\n \n \n \n';
    var footer = '\n$superiorLine\n \n';

    return '$superiorLine$middle$footer';
  }
}
