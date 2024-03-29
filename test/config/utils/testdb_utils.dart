import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/warehouse/warehouse.dart';

import '../app_tests_properties.dart';
import 'tests_utils.dart';

//Examples:
// db = 'test-app-dev-e6ee1-default-rtdb';
// url = "https://db.firebaseio.com/.json";
// collectionUrl = "https://test-app-dev-e6ee1-default-rtdb.firebaseio.com/products.json";
class TestDbUtils {
  final _utils = Get.put(TestsUtils());

  Future<int> countCollectionItems({
    required String url,
  }) async {
    var totalItems = 0;
    return http
        .get(Uri.parse(url), headers: {"Accept": "application/json"}).then((response) {
      var plainText = response.body;
      final json = jsonDecode(plainText);
      json == null
          ? totalItems
          : json.forEach((key, value) {
              totalItems++;
            });
      return totalItems;
    }).catchError((onError) => throw onError);
  }

  Future<List<Product>> getCollection({required String url}) {
    return http
        .get(Uri.parse(url))
        .then(_decodeResponse)
        .catchError((onError) => throw onError);
  }

  List<Product> _decodeResponse(http.Response response) {
    var _products = <Product>[];

    var plainText = response.body;
    final json = jsonDecode(plainText);
    json == null
        ? _products = []
        : json.forEach((key, value) {
            var product = Product.fromJson(value);
            product.id = key;
            _products.add(product);
          });
    return _products;
  }

  Future<bool> isDbOnline({
    required String url,
    required String dbName,
  }) async {
    return http.get(Uri.parse(url)).then((response) {
      _isDbOnlineMessage(url, response);
      return response.statusCode == 200 ? true : false;
    }).catchError((onError) => throw onError);
  }

  Future<void> cleanDb({
    required String url,
    required String dbName,
  }) async {
    await http.delete(Uri.parse(url)).then((response) {
      _cleanDb_message(dbName, response);
    });
  }

  Future<void> removeCollection(
    WidgetTester tester, {
    required String url,
    required int interval,
  }) async {
    await tester.pumpAndSettle(_utils.delay(interval));
    http.delete(Uri.parse("$url")).then((response) {
      _removeCollection_message(url, response);
    });
  }

  Future<void> removeObject(
    WidgetTester tester, {
    required String url,
    required int interval,
    required String id,
  }) async {
    await tester.pumpAndSettle(_utils.delay(interval));
    final noExtensionInDeletions = url.replaceAll('.json', '/');

    return http.delete(Uri.parse("$noExtensionInDeletions$id.json")).then((response) {
      _removeObject_message(noExtensionInDeletions, id, response);
      return response.statusCode;
    });
  }

  Future<dynamic> addObject({
    required var object,
    required String collectionUrl,
  }) async {
    await Future.delayed(_utils.delay(DELAY));
    return http
        .post(Uri.parse(collectionUrl), body: jsonEncode(object.toJson()))
        .then((response) {
      var plainText = response.body;
      Map<String, dynamic> json = jsonDecode(plainText);
      object.id = json['name'];
      return object;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<List<dynamic>> add_product_multipleTimes({
    required Object object,
    required int qtdeObjects,
    required String collectionUrl,
    required int interval,
  }) async {
    var listReturn = <Object>[];

    for (var item = 1; item <= qtdeObjects; item++) {
      await addObject(
        object: object,
        collectionUrl: collectionUrl,
      ).then((response) {
        listReturn.add(response);
        _addProduct_message(collectionUrl: collectionUrl, product: response);
      });
    }

    return Future.value(listReturn);
  }

  Future<List<dynamic>> add_productList({
    required List<Object> objectList,
    required String collectionUrl,
  }) async {
    var listReturn = <Object>[];

    for (var item = 1; item <= objectList.length; item++) {
      await addObject(
        object: objectList[item - 1],
        collectionUrl: collectionUrl,
      ).then((response) {
        listReturn.add(response);
        _addProduct_message(
          collectionUrl: collectionUrl,
          product: response,
          number: item.toString(),
        );
      });
    }
    return await Future.value(listReturn);
  }

  Future<List<dynamic>> add_multipleOrders({
    required String collectionUrl,
    required Function dataBuilder,
    required int totalItems,
  }) async {
    var inputList = <Object>[];
    var outputList = <Object>[];

    for (var i = 0; i < totalItems; i++) {
      inputList.add(dataBuilder.call());
    }

    for (var item = 1; item <= inputList.length; item++) {
      await addObject(
        object: inputList[item - 1],
        collectionUrl: collectionUrl,
      ).then((response) {
        outputList.add(response);
        _addOrder_message(
          collectionUrl: collectionUrl,
          order: response,
          number: item.toString(),
        );
      });
    }
    return await Future.value(outputList);
  }

  Future<List<dynamic>> add_multipleDepots2({
    required String collectionUrl,
    required Function dataBuilder,
    required int totalItems,
  }) async {
    var inputList = <Object>[];
    var outputList = <Object>[];

    for (var i = 0; i < totalItems; i++) {
      inputList.add(dataBuilder.call());
    }

    for (var item = 1; item <= inputList.length; item++) {
      await addObject(
        object: inputList[item - 1],
        collectionUrl: collectionUrl,
      ).then((response) {
        outputList.add(response);
        _addDepot_message(
          collectionUrl: collectionUrl,
          warehouse: response,
          number: item.toString(),
        );
      });
    }
    return await Future.value(outputList);
  }

  Future<List<dynamic>> add_multipleDepots({
    required List<Object> objectList,
    required String collectionUrl,
  }) async {
    var listReturn = <Object>[];

    for (var item = 1; item <= objectList.length; item++) {
      await addObject(
        object: objectList[item - 1],
        collectionUrl: collectionUrl,
      ).then((response) {
        listReturn.add(response);
        _addDepot_message(
          collectionUrl: collectionUrl,
          warehouse: response,
          number: item.toString(),
        );
      });
    }
    return await Future.value(listReturn);
  }

  final _headerLine = "||> >=====================================> DB ACTION "
      ">======================================>\n";

  final _footerLine = "    <================================================="
      "=======================================< \n\n";

  void _removeObject_message(
    String url_NoExtensionInDeletions,
    String id,
    http.Response response,
  ) {
    print('$_headerLine'
        '     Removing Object:\n'
        '     - URL: $url_NoExtensionInDeletions$id.json\n'
        '     - ID: $id\n'
        '     - Type: ${response.runtimeType.toString()}\n'
        '     - Status: ${response.statusCode} | ${response.statusCode == 200 ? 'SUCCESS' : 'FAIL'}\n'
        '$_footerLine');
  }

  void _cleanDb_message(String dbName, http.Response response) {
    print('$_headerLine'
        '     Removing All Collections:\n'
        '     - DB_Name: $dbName\n'
        '     - Status: ${response.statusCode} | ${response.statusCode == 200 ? 'SUCCESS' : 'FAIL'}\n'
        '$_footerLine');
  }

  void _isDbOnlineMessage(String url, http.Response response) {
    print('$_headerLine'
        '     Checking Db status:\n'
        '     - URL: $url\n'
        '     - Status: ${response.statusCode == 200 ? 'ON-LINE' : 'OFF-LINE'}\n'
        '     - Code: ${response.statusCode}\n'
        '$_footerLine');
  }

  void _removeCollection_message(
    String url,
    http.Response response,
  ) {
    print('$_headerLine'
        '     Removing Collection:\n'
        '     - URL: $url\n'
        '     - Status: ${response.statusCode} | ${response.statusCode == 200 ? 'SUCCESS' : 'FAIL'}\n'
        '$_footerLine');
  }

  void _addProduct_message({
    required String collectionUrl,
    required Product product,
    String number = '',
    int? statusCode,
  }) {
    var statusTxt = statusCode == null ? '' : '- Status: $statusCode';

    var body = '  ';
    product.toJson().forEach((key, value) => body += '* $key: $value\n       ');

    print('$_headerLine '
        '     Adding Object: $number\n'
        '     - URL: $collectionUrl\n'
        '     - ID: ${product.id}\n'
        '     - Type: ${product.runtimeType.toString()}\n'
        '     - Body:\n'
        '     $body'
        '     $statusTxt\n'
        '$_footerLine');
  }

  void _addOrder_message({
    required String collectionUrl,
    required Order order,
    String number = '',
    int? statusCode,
  }) {
    var statusTxt = statusCode == null ? '' : '- Status: $statusCode';

    var body = '  ';
    order.toJson().forEach((key, value) => body += '* $key: $value\n       ');

    print('$_headerLine '
        '     Adding Object: $number\n'
        '     - URL: $collectionUrl\n'
        '     - ID: ${order.id}\n'
        '     - Type: ${order.runtimeType.toString()}\n'
        '     - Body:\n'
        '     $body'
        '     $statusTxt\n'
        '$_footerLine');
  }

  void _addDepot_message<E>({
    required String collectionUrl,
    required Warehouse warehouse,
    String number = '',
    int? statusCode,
  }) {
    var statusTxt = statusCode == null ? '' : '- Status: $statusCode';

    var body = '  ';
    warehouse.toJson().forEach((key, value) => body += '* $key: $value\n       ');

    print('$_headerLine '
        '     Adding Object: $number\n'
        '     - URL: $collectionUrl\n'
        '     - ID: ${warehouse.id}\n'
        '     - Type: ${warehouse.runtimeType.toString()}\n'
        '     - Body:\n'
        '     $body'
        '     $statusTxt\n'
        '$_footerLine');
  }


}