import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'test_utils.dart';

class UiTestUtils {
  final TestUtils _seek = Get.put(TestUtils());

  void navigationBetweenViews(
    WidgetTester tester, {
    int interval,
    Type from,
    Type to,
    Type triggerWidget,
  }) async {
    expect(_seek.type(from), findsOneWidget);
    await tester.tap(_seek.type(triggerWidget));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(interval));
    expect(_seek.type(to), findsOneWidget);
  }

  Future tapButtonWithResult(
    WidgetTester tester, {
    int interval,
    String triggerKey,
    Type resultWidget,
  }) async {
    await tester.tap(_seek.key(triggerKey));
    await tester.pump();
    await tester.pump(_seek.delay(interval));
    await tester.pumpAndSettle();
    expect(_seek.type(resultWidget), findsWidgets);
  }

  Future openDrawerAndClickAnOption(
    WidgetTester tester, {
    int interval,
    String optionKey,
    GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState.openDrawer();
    await tester.pumpAndSettle(Duration(milliseconds: interval * 1000 + 1700));
    await tester.tap(_seek.key(optionKey));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: interval * 1000 + 1700));
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

  Future sendAppToBackground({int interval}) async {
    await Future.delayed(Duration(seconds: interval), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testInitialization(
    tester, {
    bool isWidgetTest,
    Widget driver,
  }) async {
    isWidgetTest ? await tester.pumpWidget(driver) : runApp(driver);
  }
}
