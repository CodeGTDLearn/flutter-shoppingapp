import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../../orders/service/i_orders_service.dart';
import '../entities/cart_item.dart';
import '../service/i_cart_service.dart';

class CartController extends GetxController  {

  final ICartService cartService;
  final IOrdersService ordersService;

  var qtdeCartItems = 0.obs;
  var amountCartItems = 0.0.obs;

  CartController({this.cartService, this.ordersService});

  @override
  void onInit() {
    recalcQtdeAndAmountCart();
  }

  Map<String, CartItem> getAll() {
    return cartService.getAllCartItems();
  }

  void addProductInTheCart(Product product) {
    cartService.addCartItem(product);
    recalcQtdeAndAmountCart();
  }

  void undoAddProductInTheCart(Product product) {
    cartService.addCartItemUndo(product);
    recalcQtdeAndAmountCart();
  }

  void recalcQtdeAndAmountCart() {
    qtdeCartItems.value = cartService.cartItemsQtde();
    amountCartItems.value = cartService.cartItemTotal$Amount();
  }

  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    recalcQtdeAndAmountCart();
  }

  void clearCart() {
    cartService.clearCart();
    recalcQtdeAndAmountCart();
  }


  void addOrder(List<CartItem> cartItemsList, double amount) {
    ordersService.addOrder(cartItemsList, amount);
  }
}
