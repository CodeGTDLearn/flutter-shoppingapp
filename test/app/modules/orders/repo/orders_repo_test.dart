import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';

import '../../../../config/data_builders/order_databuilder.dart';
import '../../../../config/datasource/mocked_datasource.dart';
import '../core/orders_test_bindings.dart';
import '../core/orders_test_titles.dart';

class OrdersRepoTests {
  void unit() {
    late IOrdersRepo _repo;
    var _orderWithoutId;
    late Order _order0, _order1;
    final _titles = Get.put(OrdersTestTitles());
    final _bindings = Get.put(OrdersTestBindings());
    final _builder = Get.put(OrderDatabuilder());

    setUp(() {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _orderWithoutId = _builder.Order_full_withoutId();
      _repo = Get.find<IOrdersRepo>();
      _order0 = Get.put(MockedDatasource()).orders().elementAt(0);
      _order1 = Get.put(MockedDatasource()).orders().elementAt(1);
    });

    test(_titles.repo_get_orders, () {
      _repo.getOrders().then((resp) {
        expect(resp.elementAt(0).id, _order0.id);
        expect(resp.elementAt(0).cartItems.elementAt(0).id,
            _order0.cartItems.elementAt(0).id);

        expect(resp.elementAt(1).id, _order1.id);
        expect(resp.elementAt(1).cartItems.elementAt(0).id,
            _order1.cartItems.elementAt(0).id);
      });
    });

    test(_titles.repo_add_order, () {
      var id = Faker().randomGenerator.string(20, min: 20);
      _repo.addOrder(_orderWithoutId).then((response) {
        response = _orderWithoutId;
        response.id = id;
        expect(response.id, id);
      });
    });
  }
}