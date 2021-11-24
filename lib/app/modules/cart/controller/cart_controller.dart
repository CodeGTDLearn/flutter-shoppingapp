import 'package:get/state_manager.dart';

import '../../inventory/entity/product.dart';
import '../../orders/entity/order.dart';
import '../../orders/service/i_orders_service.dart';
import '../entity/cart_item.dart';
import '../service/i_cart_service.dart';

class CartController extends GetxController {
  final ICartService cartService;
  final IOrdersService ordersService;

  var renderListView = true.obs;

  var qtdeCartItemsObs = 0.obs;
  var amountCartItemsObs = 0.0.obs;

  CartController({required this.cartService, required this.ordersService});

  void onInit() {
    recalcQtdeAndAmountCart();
    super.onInit();
  }

  Map<String, CartItem> getAllCartItems() {
    return cartService.getAllCartItems();
  }

  void addCartItem(Product product) {
    cartService.addCartItem(product);
    recalcQtdeAndAmountCart();
  }

  void addCartItemUndo(Product product) {
    cartService.addCartItemUndo(product);
    recalcQtdeAndAmountCart();
  }

  void recalcQtdeAndAmountCart() {
    amountCartItemsObs.value = cartService.amountCartItems();
    qtdeCartItemsObs.value = cartService.qtdeCartItems();
  }

  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    recalcQtdeAndAmountCart();
  }

  void clearCart() {
    cartService.clearCart();
    recalcQtdeAndAmountCart();
  }

  Future<Order> addOrder(List<CartItem> cartItems, double amount) {
    return ordersService
        .addOrder(cartItems, amount)
        .catchError((onError) => throw onError);
  }

  int getQtdeCartItemsObs() {
    return qtdeCartItemsObs.value;
  }

  double getAmountCartItemsObs() {
    return amountCartItemsObs.value;
  }
}