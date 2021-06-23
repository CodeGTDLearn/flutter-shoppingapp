import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import 'test_utils.dart';

class ViewTestUtils {
  final _seek = Get.put(TestUtils());

  void navigationBetweenViews(
    WidgetTester tester, {
    int delaySeconds,
    Type from,
    Type to,
    Type triggerElement,
  }) async {
    expect(_seek.type(from), findsOneWidget);
    await tester.tap(_seek.type(triggerElement));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    expect(_seek.type(to), findsOneWidget);
  }

  Future tapButtonWithResult(
    WidgetTester tester, {
    int delaySeconds,
    String keyWidgetTrigger,
    Type typeWidgetResult,
  }) async {
    await tester.tap(_seek.key(keyWidgetTrigger));
    await tester.pump();
    await tester.pump(_seek.delay(delaySeconds));
    await tester.pumpAndSettle();
    expect(_seek.type(typeWidgetResult), findsWidgets);
  }

  Future openDrawerAndClickAnOption(
    WidgetTester tester, {
    int delaySeconds,
    String clickedKeyOption,
    GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState.openDrawer();
    await tester.pumpAndSettle(Duration(milliseconds: delaySeconds * 1000 + 1700));
    await tester.tap(_seek.key(clickedKeyOption));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: delaySeconds * 1000 + 1700));
  }

  void checkWidgetsQtdeInOneView({
    Type widgetView,
    Type widgetType,
    int widgetQtde,
  }) {
    expect(_seek.type(widgetView), findsOneWidget);
    expect(
      _seek.type(widgetType),
      widgetQtde == 0 ? findsNothing : findsWidgets,
    );
  }

  Future removeCollectionFromDb(
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

  Future removeObjectFromDb(
    tester, {
    String url,
    int delaySeconds,
    String idElement,
  }) async {
    await tester.pumpAndSettle(_seek.delay(delaySeconds));

    final noExtensionInDeletions = url.replaceAll('.json', '/');
    return http
        .delete(Uri.parse("$noExtensionInDeletions$idElement.json"))
        .then((response) {
      print('  \n Removing Db Element:\n'
          ' - URL: $noExtensionInDeletions$idElement.json\n'
          ' - ID: $idElement\n'
          ' - Status: ${response.statusCode}\n');
      return response.statusCode;
    });
  }

  Future addObjectInDb(
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

  Future<List<Object>> addObjectsInDb(
    tester, {
    int qtdeObjects,
    Object object,
    String collectionUrl,
    int delaySeconds,
  }) async {
    var listReturn = <Object>[];
    qtdeObjects ??= 1;

    for (var item = 1; item <= qtdeObjects; item++) {
      await addObjectInDb(
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

  Future sendAppToBackground({int delaySeconds}) async {
    await Future.delayed(Duration(seconds: delaySeconds), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testsInitialization(
    tester, {
    bool testType,
    Widget appDriver,
  }) async {
    testType ? await tester.pumpWidget(appDriver) : runApp(appDriver);
  }

  void globalSetUpAll(String testModuleName) {
    print('\n '
        '\n>>=============================================================>>'
        '\n>>=============================================================>>'
        '\n>>========> Starting FunctionalTests: $testModuleName'
        '\n>>=============================================================>>'
        '\n>>=============================================================>>\n'
        '\n \n \n');
  }

  void globalTearDownAll(String testModuleName) {
    print('\n<<=============================================================<<\n'
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
        '>---------> Test: $testModuleName >---------> \n \n');
  }

  void globalTearDown(String testModuleName) {
    print('\n \n'
        '<---------< Test: $testModuleName <---------< \n'
        '<---------------------------------------------------------------<'
        '\n \n \n');
    Get.reset;
  }
}
