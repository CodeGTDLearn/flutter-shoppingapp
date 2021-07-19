import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'test_utils.dart';

class UiTestUtils {
  final TestUtils _seek = Get.put(TestUtils());

  void navigationBetweenViews(
    WidgetTester tester, {
    required int interval,
    required Type from,
    required Type to,
    required Type triggerWidget,
  }) async {
    expect(_seek.type(from), findsOneWidget);
    await tester.tap(_seek.type(triggerWidget));
    await tester.pump();
    await tester.pumpAndSettle(_seek.delay(interval));
    expect(_seek.type(to), findsOneWidget);
  }

  Future tapButtonWithResult(
    WidgetTester tester, {
    required int interval,
    required String triggerKey,
    required Type resultWidget,
  }) async {
    await tester.tap(_seek.key(triggerKey));
    await tester.pump();
    await tester.pump(_seek.delay(interval));
    await tester.pumpAndSettle();
    expect(_seek.type(resultWidget), findsWidgets);
  }

  Future openDrawerAndClickAnOption(
    WidgetTester tester, {
    required int interval,
    required String optionKey,
    required GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState!.openDrawer();
    await tester.pumpAndSettle(Duration(milliseconds: interval * 1000 + 1700));
    await tester.tap(_seek.key(optionKey));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: interval * 1000 + 1700));
  }

  void checkWidgetsTypesQtdeInAView({
    required Type widgetView,
    required Type widgetType,
    required int widgetQtde,
  }) {
    expect(_seek.type(widgetView), findsOneWidget);
    expect(
      _seek.type(widgetType),
      widgetQtde == 0 ? findsNothing : findsWidgets,
    );
  }

  Future sendAppToBackground({required int interval}) async {
    await Future.delayed(Duration(seconds: interval), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testInitialization(
    tester, {
    required bool isWidgetTest,
    required Widget driver,
  }) async {
    isWidgetTest ? await tester.pumpWidget(driver) : runApp(driver);
  }
}
