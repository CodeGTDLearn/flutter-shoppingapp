import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'db_test_utils.dart';
import 'test_utils.dart';

class UiTestUtils {
  final TestUtils _seek = Get.put(TestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());

  void navigationBetweenViews(
    WidgetTester tester, {
    int delaySeconds,
    Type from,
    Type to,
    Type triggerWidget,
  }) async {
    expect(_seek.type(from), findsOneWidget);
    await tester.tap(_seek.type(triggerWidget));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    expect(_seek.type(to), findsOneWidget);
  }

  Future tapButtonWithResult(
    WidgetTester tester, {
    int delaySeconds,
    String triggerKey,
    Type resultWidget,
  }) async {
    await tester.tap(_seek.key(triggerKey));
    await tester.pump();
    await tester.pump(_seek.delay(delaySeconds));
    await tester.pumpAndSettle();
    expect(_seek.type(resultWidget), findsWidgets);
  }

  Future openDrawerAndClickAnOption(
    WidgetTester tester, {
    int delaySeconds,
    String optionKey,
    GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState.openDrawer();
    await tester.pumpAndSettle(Duration(milliseconds: delaySeconds * 1000 + 1700));
    await tester.tap(_seek.key(optionKey));
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

  Future sendAppToBackground({int delaySeconds}) async {
    await Future.delayed(Duration(seconds: delaySeconds), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testInitialization(
    tester, {
    bool isWidgetTest,
    Widget appDriver,
  }) async {
    isWidgetTest ? await tester.pumpWidget(appDriver) : runApp(appDriver);
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

  void globalTearDownAll(String testModuleName) async {
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
