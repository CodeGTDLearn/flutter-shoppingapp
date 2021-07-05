import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/app_tests_config.dart';
import 'test_utils.dart';

class DbTestUtils {
  final _seek = Get.put(TestUtils());

  Future cleanDb({String url, String db, int interval}) async {
    http.delete(Uri.parse(url)).then((response) {
      print('  \n Removing All Collections in Db:\n'
          ' - DB_Name: $db\n'
          ' - Status: ${response.statusCode}\n');
    });

    sleep(Duration(seconds: DELAY * 2));
  }

  Future removeCollection(
    tester, {
    String url,
    int interval,
  }) async {
    await tester.pumpAndSettle(_seek.delay(interval));
    http.delete(Uri.parse("$url")).then((response) {
      print('  \n Removing Db Collection:\n'
          ' - URL: $url\n'
          ' - Status: ${response.statusCode}\n');
    });
  }

  Future removeObject(
    tester, {
    String url,
    int interval,
    String id,
  }) async {
    await tester.pumpAndSettle(_seek.delay(interval));
    final noExtensionInDeletions = url.replaceAll('.json', '/');

    return http.delete(Uri.parse("$noExtensionInDeletions$id.json")).then((response) {
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
    int interval,
  }) async {
    await tester.pumpAndSettle(_seek.delay(interval));

    // @formatter:off
    return http
        .post(Uri.parse(collectionUrl), body: jsonEncode(object.toJson()))
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
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<List<Object>> addMultipleObjects(
    tester, {
    int qtdeObjects,
    Object object,
    String collectionUrl,
    int interval,
  }) async {
    var listReturn = <Object>[];
    qtdeObjects ??= 1;

    for (var item = 1; item <= qtdeObjects; item++) {
      await addObject(
        tester,
        object: object,
        interval: interval,
        collectionUrl: collectionUrl,
      ).then((responseObject) {
        listReturn.add(responseObject);
      });
    }

    return Future.value(listReturn);
  }
}
