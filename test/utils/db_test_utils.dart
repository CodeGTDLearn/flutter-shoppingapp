import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import 'test_utils.dart';

//Examples:
// db = 'test-app-dev-e6ee1-default-rtdb';
// url = "https://db.firebaseio.com/.json";
// collectionUrl = "https://test-app-dev-e6ee1-default-rtdb.firebaseio.com/products.json";
class DbTestUtils {
  final _utils = Get.put(TestUtils());

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

  Future<dynamic> addObject(
    tester, {
    required var object,
    required String collectionUrl,
    required int interval,
  }) async {
    await tester.pumpAndSettle(_utils.delay(interval));

    return http
        .post(Uri.parse(collectionUrl), body: jsonEncode(object.toJson()))
        .then((response) {
      var plainText = response.body;
      Map<String, dynamic> json = jsonDecode(plainText);
      object.id = json['name'];

      // _addProductMessage(
      //   collectionUrl: collectionUrl,
      //   product: object,
      //   statusCode: response.statusCode,
      // );

      return object;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<List<dynamic>> addMultipleObjects(
    tester, {
    required int qtdeObjects,
    required Object object,
    required String collectionUrl,
    required int interval,
  }) async {
    var listReturn = <Object>[];

    for (var item = 1; item <= qtdeObjects; item++) {
      await addObject(
        tester,
        object: object,
        interval: interval,
        collectionUrl: collectionUrl,
      ).then((responseObject) {
        listReturn.add(responseObject);
        _addProductMessage(
          collectionUrl: collectionUrl,
          product: responseObject,
        );
      });
    }

    return Future.value(listReturn);
  }

  final _headerLineMsg =
      "||> >=======================> DB ACTION >========================>\n";
  final _footerLineMsg =
      "    <=======================< DB ACTION <========================< <||\n\n\n";

  void _removeObjectMessage(
    String url_NoExtensionInDeletions,
    String id,
    http.Response response,
  ) {
    print('$_headerLineMsg'
        ' Removing Object:\n'
        ' - URL: $url_NoExtensionInDeletions$id.json\n'
        ' - ID: $id\n'
        ' - Type: ${response.runtimeType.toString()}\n'
        ' - Status: ${response.statusCode}\n'
        '$_footerLineMsg');
  }

  void _cleanDbMessage(String dbName, http.Response response) {
    print('$_headerLineMsg'
        '    Removing All Collections:\n'
        '    - DB_Name: $dbName\n'
        '    - Status: ${response.statusCode}\n'
        '$_footerLineMsg');
  }

  void _removeCollectionMessage(String url, http.Response response) {
    print('$_headerLineMsg'
        '    Removing Collection:\n'
        '    - URL: $url\n'
        '    - Status: ${response.statusCode}\n'
        '$_footerLineMsg');
  }

  void _addProductMessage({
    required String collectionUrl,
    required Product product,
    int? statusCode,
  }) {
    var statusTxt = statusCode == null ? '' : '    - Status: $statusCode\n';

    print('$_headerLineMsg'
        '    Adding Object:\n'
        '    - URL: $collectionUrl\n'
        '    - ID: ${product.id}\n'
        '    - Type: ${product.runtimeType.toString()}\n'
        '$statusTxt'
        '$_footerLineMsg');
  }
}

// Future<dynamic> addObjectsInDbManually({
//   required int qtdeObjects,
//   required var object,
//   required String collectionUrl,
//   required String dbUrl,
//   required String dbName,
// }) async {
//   // Example:
//   // dbName = 'test-app-dev-e6ee1-default-rtdb';
//   // dbUrl = "https://$dbName.firebaseio.com/.json";
//   await cleanDb(dbUrl: dbUrl, dbName: dbName);
//
//   // Example:
//   // collectionUrl = "https://test-app-dev-e6ee1-default-rtdb.firebaseio.com/products.json";
//   var listReturn = <Object>[];
//   for (var item = 1; item <= qtdeObjects; item++) {
//     // @formatter:off
//     return http
//         .post(Uri.parse(collectionUrl), body: jsonEncode(object.toJson()))
//         .then((responseObject) {
//       var plainText = responseObject.body;
//       Map<String, dynamic> json = jsonDecode(plainText);
//       object.id = json['name'];
//
//       // _addObjectMessage(collectionUrl, object, responseObject);
//       _addObjectMessage(
//         collectionUrl: collectionUrl,
//         response: responseObject,
//         object: object,
//       );
//
//       listReturn.add(responseObject);
//     }).catchError((onError) => throw onError);
//     // @formatter:on
//   }
//
//   return Future.value(listReturn);
// }
