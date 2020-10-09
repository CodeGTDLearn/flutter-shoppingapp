import '../../cart/entities/cart_item.dart';
import '../entities/order.dart';
import '../repo/i_orders_repo.dart';
import 'i_orders_service.dart';

class OrdersService implements IOrdersService {
  final IOrdersRepo repo;

  List<Order> _dataSavingOrders = [];

  OrdersService({this.repo});

  @override
  List<Order> getOrders() {
    repo.getOrders().then((response) {
      _dataSavingOrders = response;
      // return response;
    });
    return _dataSavingOrders;
  }

  @override
  void clearOrders() {
    _dataSavingOrders = [];
    repo.clearOrders();
  }

  @override
  void addOrder(List<CartItem> cartItemsList, double amount) {
    var newOrder = Order(
      DateTime.now().toString(),
      amount.toString(),
      DateTime.now().toString(),
      cartItemsList,
    );
    _dataSavingOrders.add(newOrder);
    repo.saveOrder(newOrder);
  }

  @override
  int ordersQtde() {
    return _dataSavingOrders.length;
  }
}
