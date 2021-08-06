import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shopingapp/app_driver.dart' as app;

import 'test_utils.dart';

class UiTestUtils {
  final TestUtils _seek = Get.put(TestUtils());

  Future<void> navigationBetweenViews(
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

  Future<void> tapButtonWithResult(
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

  Future<void> openDrawerAndClickAnOption(
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

  Future<void> sendAppToBackground({required int interval}) async {
    await Future.delayed(Duration(seconds: interval), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testBootstrapPreserveStateOld(
    tester, {
    required bool isWidgetTest,
    required Widget appDriver,
  }) async {
    isWidgetTest ? await tester.pumpWidget(appDriver) : runApp(appDriver);
  }

  Future<void> testBootstrapPreserveState(
    tester, {
    required bool isWidgetTest,
  }) async {
    isWidgetTest
        ? await tester.pumpWidget(app.AppDriver())
        : runApp(
            app.AppDriver(),
          );
  }

  Future<void> testBootstrapRestartState(
    tester, {
    required bool isWidgetTest,
  }) async {
    isWidgetTest
        ? await tester.pumpWidget(app.AppDriver())
        : runApp(
            Phoenix(child: app.AppDriver()), //<<<<<<<<<< trabalhar no reinicio de
            // estado a aplicacao em cada ciclo de test de integracao
          );
  }
}
