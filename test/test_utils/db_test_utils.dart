import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'test_utils.dart';

class DbTestUtils {
  final _seek = Get.put(TestUtils());

  Future removeAllCollections(
    tester, {
    String dbName,
    int delaySeconds,
  }) async {
    await tester.pumpAndSettle(_seek.delay(delaySeconds));

    var url = "https://$dbName.firebaseio.com/.json";

    http.delete(Uri.parse(url)).then((response) {
      print('  \n Removing All Collections in Db:\n'
          ' - DB_Name: $dbName\n'
          ' - Status: ${response.statusCode}\n');
    });
  }

  Future removeCollection(
    tester, {
    String url,
    int delaySeconds,
  }) async {
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    http.delete(Uri.parse("$url")).then((response) {
      print('  \n Removing Db Collection:\n'
          ' - URL: $url\n'
          ' - Status: ${response.statusCode}\n');
    });
  }

  Future removeObject(
    tester, {
    String url,
    int delaySeconds,
    String id,
  }) async {
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    final noExtensionInDeletions = url.replaceAll('.json', '/');

    return http
        .delete(Uri.parse("$noExtensionInDeletions$id.json"))
        .then((response) {
      print('  \n Removing Db Object:\n'
          ' - URL: $noExtensionInDeletions$id.json\n'
          ' - ID: $id\n'
          ' - Status: ${response.statusCode}\n');
      return response.statusCode;
    });
  }

  Future addObject(
    tester, {
    var object,
    String collectionUrl,
    int delaySeconds,
  }) async {
    await tester.pumpAndSettle(_seek.delay(delaySeconds));

    // @formatter:off
    return
         http.post(Uri.parse(collectionUrl), body: jsonEncode(object.toJson()))
        .then((response) {
               var plainText = response.body;
               Map<String, dynamic> json = jsonDecode(plainText);
               object.id = json['name'];

               print('  \n Adding Object in Db:\n'
                     ' - URL: $collectionUrl\n'
                     ' - ID: ${object.id}\n'
                     ' - Type: ${object.runtimeType.toString()}\n'
                     ' - Status: ${response.statusCode}\n ');

               return object;
              })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<List<Object>> addMultipleObjects(
    tester, {
    int qtdeObjects,
    Object object,
    String collectionUrl,
    int delaySeconds,
  }) async {
    var listReturn = <Object>[];
    qtdeObjects ??= 1;

    for (var item = 1; item <= qtdeObjects; item++) {
      await addObject(
        tester,
        object: object,
        delaySeconds: delaySeconds,
        collectionUrl: collectionUrl,
      ).then((responseObject) {
        listReturn.add(responseObject);
      });
    }

    return Future.value(listReturn);
  }
}
