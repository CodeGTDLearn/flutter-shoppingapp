import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../config/tests_config.dart';
import 'test_utils.dart';

//Examples:
// db = 'test-app-dev-e6ee1-default-rtdb';
// url = "https://db.firebaseio.com/.json";
// collectionUrl = "https://test-app-dev-e6ee1-default-rtdb.firebaseio.com/products.json";
class DbTestUtils {
  final _utils = Get.put(TestUtils());

  Future<int> countCollectionItems({required String collectionUrl}) async {
    var totalItems = 0;
    return http.get(Uri.parse(collectionUrl),
        headers: {"Accept": "application/json"}).then((response) {
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

  Future<void> cleanDb({
    required String dbUrl,
    required String dbName,
  }) async {
    await http.delete(Uri.parse(dbUrl)).then((response) {
      _cleanDbMessage(dbName, response);
    });
  }

  Future<void> removeCollection(
    tester, {
    required String url,
    required int interval,
  }) async {
    await tester.pumpAndSettle(_utils.delay(interval));
    http.delete(Uri.parse("$url")).then((response) {
      _removeCollectionMessage(url, response);
    });
  }

  Future<void> removeObject(
    tester, {
    required String url,
    required int interval,
    required String id,
  }) async {
    await tester.pumpAndSettle(_utils.delay(interval));
    final noExtensionInDeletions = url.replaceAll('.json', '/');

    return http.delete(Uri.parse("$noExtensionInDeletions$id.json")).then((response) {
      _removeObjectMessage(noExtensionInDeletions, id, response);
      return response.statusCode;
    });
  }

  Future<dynamic> addObject({
    required var object,
    required String collectionUrl,
    required int interval,
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

  Future<List<dynamic>> addMultipleObjects({
    required int qtdeObjects,
    required Object object,
    required String collectionUrl,
    required int interval,
  }) async {
    var listReturn = <Object>[];

    for (var item = 1; item <= qtdeObjects; item++) {
      await addObject(
        object: object,
        interval: interval,
        collectionUrl: collectionUrl,
      ).then((response) {
        listReturn.add(response);
        _addProductMessage(collectionUrl: collectionUrl, product: response);
      });
    }

    return Future.value(listReturn);
  }

  final _headerLine =
      "||> >=======================> DB ACTION >========================>\n";
  final _footerLine =
      "    <=======================< DB ACTION <========================< <||\n";

  void _removeObjectMessage(
    String url_NoExtensionInDeletions,
    String id,
    http.Response response,
  ) {
    print('$_headerLine'
        ' Removing Object:\n'
        ' - URL: $url_NoExtensionInDeletions$id.json\n'
        ' - ID: $id\n'
        ' - Type: ${response.runtimeType.toString()}\n'
        ' - Status: ${response.statusCode}\n'
        '$_footerLine');
  }

  void _cleanDbMessage(String dbName, http.Response response) {
    print('$_headerLine'
        '    Removing All Collections:\n'
        '    - DB_Name: $dbName\n'
        '    - Status: ${response.statusCode}\n'
        '$_footerLine');
  }

  void _removeCollectionMessage(String url, http.Response response) {
    print('$_headerLine'
        '    Removing Collection:\n'
        '    - URL: $url\n'
        '    - Status: ${response.statusCode}\n'
        '$_footerLine');
  }

  void _addProductMessage({
    required String collectionUrl,
    required Product product,
    int? statusCode,
  }) {
    var statusTxt = statusCode == null ? '' : '    - Status: $statusCode\n';

    print('$_headerLine'
        '    Adding Object:\n'
        '    - URL: $collectionUrl\n'
        '    - ID: ${product.id}\n'
        '    - Type: ${product.runtimeType.toString()}\n'
        '$statusTxt'
        '$_footerLine');
  }
}
