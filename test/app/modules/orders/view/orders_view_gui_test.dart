import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/modules/cart/view/cart_view.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Orders|Gui-Tests: ', gui);
}

void gui() {
  TestUtils _seek;
  var ordersViewTests = Get.put(OrdersViewTests());
  var testConfig = Get.put(OrdersTestConfig());
  var executingBindings;

  setUp(() {
    executingBindings = testConfig.bindingsBuilderMockedRepo(execute: false);
    _seek = Get.put(TestUtils());
  });

  tearDown(Get.reset);

  testWidgets('${testConfig.OrderingFromCartProductsButtonOrderNow}', (tester) async {
    executingBindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
    await ordersViewTests.Test_OrderingFromCartViewUsingTheButtonOrderNow(tester, _seek);
  });

  testWidgets('${testConfig.OpenOrderPageWITHanOrderInDB}', (tester) async {
    executingBindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
    await ordersViewTests.openDrawerAndClickOrdersOption(tester, _seek);
    await ordersViewTests.checkOneOrderInOrdersView(_seek, widgetsLeastQtde: 1);
  },skip: true);

  testWidgets('${testConfig.TestPageBackButton}', (tester) async {
    executingBindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
    await ordersViewTests.openDrawerAndClickOrdersOption(tester, _seek);
    await ordersViewTests.Test_PageBackButton(_seek, tester);
  },skip: true);
}