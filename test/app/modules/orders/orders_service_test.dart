import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';

import '../../../config/titles/orders_test_titles.dart';
import '../../../datasource/mocked_datasource.dart';
import '../../core/bindings/orders_test_bindings.dart';

class OrdersServiceTests {
  void unit() {
    late IOrdersService _service;
    late Order _order0;
    final _titles = Get.find<OrdersTestTitles>();
    final _bindings = Get.find<OrdersTestBindings>();

    setUp(() {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _service = Get.find<IOrdersService>();
      _order0 = Get.put(MockedDatasource()).orders().elementAt(0);
    });

    test(_titles.service_get_orders, () {
      _service.getOrders().then((listReturn) {
        expect(listReturn.elementAt(0).id, _order0.id);
        expect(listReturn.elementAt(0).datetime, _order0.datetime);
        expect(listReturn.elementAt(0).amount, _order0.amount);
        expect(listReturn.elementAt(0).cartItems.elementAt(0).id,
            _order0.cartItems.elementAt(0).id);
        expect(listReturn.elementAt(0).cartItems.elementAt(0).title,
            _order0.cartItems.elementAt(0).title);
      });
    });

    test(_titles.service_get_local_orders, () {
      _service.getOrders().then((_) {
        var list = _service.getLocalDataOrders();
        expect(list.elementAt(0).id, _order0.id);
        expect(list.elementAt(0).datetime, _order0.datetime);
        expect(list.elementAt(0).amount, _order0.amount);
        expect(list.elementAt(0).cartItems.elementAt(0).id,
            _order0.cartItems.elementAt(0).id);
        expect(list.elementAt(0).cartItems.elementAt(0).title,
            _order0.cartItems.elementAt(0).title);
      });
    });

    test(_titles.service_get_orfers_qtde, () {
      _service.getOrders().then((listReturned) {
        var listLocalData = _service.getLocalDataOrders();
        expect(listLocalData.length, _service.ordersQtde());
        expect(listReturned.length, _service.ordersQtde());
      });
    });

    test(_titles.service_clean_orders, () {
      _service.getOrders().then((_) {
        var list = _service.getLocalDataOrders();
        expect(list.length, _service.ordersQtde());
        _service.clearOrder();
        expect(_service.ordersQtde(), 0);
      });
    });
  }
}