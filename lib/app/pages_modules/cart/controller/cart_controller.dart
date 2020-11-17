import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../../orders/entities/order.dart';
import '../../orders/service/i_orders_service.dart';
import '../entities/cart_item.dart';
import '../service/i_cart_service.dart';
import 'i_cart_controller.dart';

class CartController extends GetxController implements ICartController {
  final ICartService cartService;
  final IOrdersService ordersService;

  var qtdeCartItems = 0.obs;
  var amountCartItems = 0.0.obs;

  CartController({this.cartService, this.ordersService});

  @override
  void onInit() {
    recalcQtdeAndAmountCart();
  }

  @override
  Map<String, CartItem> getAllCartItems() {
    return cartService.getAllCartItems();
  }

  @override
  void addCartItem(Product product) {
    cartService.addCartItem(product);
    recalcQtdeAndAmountCart();
  }

  @override
  void addCartItemUndo(Product product) {
    cartService.addCartItemUndo(product);
    recalcQtdeAndAmountCart();
  }

  @override
  void recalcQtdeAndAmountCart() {
    qtdeCartItems.value = cartService.cartItemsQtde();
    amountCartItems.value = cartService.cartItemTotal$Amount();
  }

  @override
  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    recalcQtdeAndAmountCart();
  }

  @override
  void clearCart() {
    cartService.clearCart();
    recalcQtdeAndAmountCart();
  }

  @override
  Future<Order> addOrder(List<CartItem> cartItems, double amount) {
    return ordersService.addOrder(cartItems, amount);
  }

  @override
  int getQtdeCartItemsObs(){
    return qtdeCartItems.value;
  }

  @override
  double getAmountCartItemsObs(){
    return amountCartItems.value;
  }

}
