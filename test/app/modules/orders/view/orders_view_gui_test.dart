import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../orders_test_config.dart';
import 'orders_view_tests.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Orders|Gui-Tests: ', gui);
}

void gui() {
  var tests = Get.put(OrdersViewTests());
  var testConfig = Get.put(OrdersTestConfig());
  var bindings;

  setUp(() {
    bindings = testConfig.bindingsBuilderMockedRepo(execute: false);
  });

  tearDown(Get.reset);

  testWidgets('${testConfig.OrderingFromCartViewUsingTheButtonOrderNow}', (tester) async {
    bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

    await tests.addOneProductInDB(tester, testWithValidTexts: true);
    await tests.Test_OrderingFromCartViewUsingTheButtonOrderNow(tester);
  });

  testWidgets('${testConfig.OpenOrderViewWithAnOrderInDB}', (tester) async {
    bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
    await tests.openDrawerAndClickAnOption(
      tester,
      keyOption: DRAWER_ORDER_OPTION_KEY,
    );
    await tests.checkOneOrderInOrdersView(widgetsMinimalQtde: 1);
  });


  testWidgets('${testConfig.TestPageBackButton}', (tester) async {
    bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
    await tests.openDrawerAndClickAnOption(
      tester,
      keyOption: DRAWER_ORDER_OPTION_KEY,
    );
    await tests.Test_OrderViewTapBackButton(
      tester,
      from: OrdersView,
      to: OverviewView,
    );
  });
}
