import '../../cart/entities/cart_item.dart';
import '../entities/order.dart';
import '../repo/i_orders_repo.dart';
import 'i_orders_service.dart';

class OrdersService implements IOrdersService {
  final IOrdersRepo repo;

  List<Order> _localDataOrders = [];

  OrdersService({this.repo});

  @override
  Future<Order> addOrder(List<CartItem> cartItems, double amount) {
    var orderTimeStamp = DateTime.now();
    var order = Order(
      amount.toStringAsFixed(2),
      orderTimeStamp.toIso8601String(),
      cartItems,
    );

    // @formatter:off
    return repo
            .addOrder(order)
            .then((value) {
                order.datetime = orderTimeStamp.toString();
                _localDataOrders.add(order);
                return value;})
            .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<List<Order>> getOrders() {
    return repo.getOrders().then((response) {
      _localDataOrders = response;
       return response;
    }).catchError((onError) => throw onError);
  }

  @override
  void clearOrders() {
    _localDataOrders = [];
    // repo.clearOrders();
  }

  @override
  int ordersQtde() {
    return _localDataOrders.length;
  }
}
