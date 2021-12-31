import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

import '../../inventory/entity/product.dart';
import '../../orders/entity/order.dart';
import '../../orders/service/i_orders_service.dart';
import '../entity/cart_item.dart';
import '../service/i_cart_service.dart';

class CartController extends GetxController with GetSingleTickerProviderStateMixin {
  final ICartService cartService;
  final IOrdersService ordersService;
  late AnimationController _badgeShopCartAnimationController;
  late Animation badgeShopCartAnimation;

  var renderListView = true.obs;
  var qtdeCartItemsObs = 0.obs;
  var amountCartItemsObs = 0.0.obs;

  CartController({required this.cartService, required this.ordersService});

  @override
  void onInit() {
    reloadQtdeAndAmountCart();
    super.onInit();

    _badgeShopCartAnimationSetup();
  }

  Map<String, CartItem> getAllCartItems() {
    return cartService.getAllCartItems();
  }

  void addCartItem(Product product) {
    cartService.addCartItem(product);
    reloadQtdeAndAmountCart();
    _badgeShopCartAnimationPlay();
  }

  void addCartItemUndo(Product product) {
    cartService.addCartItemUndo(product);
    reloadQtdeAndAmountCart();
  }

  void reloadQtdeAndAmountCart() {
    amountCartItemsObs.value = cartService.amountCartItems();
    qtdeCartItemsObs.value = cartService.qtdeCartItems();
  }

  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    reloadQtdeAndAmountCart();
  }

  void clearCart() {
    cartService.clearCart();
    reloadQtdeAndAmountCart();
  }

  Future<Order> addOrder(List<CartItem> cartItems, double amount) {
    return ordersService
        .addOrder(cartItems, amount)
        .catchError((onError) => throw onError);
  }

  void _badgeShopCartAnimationSetup() {
    _badgeShopCartAnimationController =
        AnimationController(duration: const Duration(milliseconds: 225), vsync: this);

    badgeShopCartAnimation = Tween<Offset>(
      begin: const Offset(0, 0.0),
      end: const Offset(.2, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _badgeShopCartAnimationController,
        curve: Curves.elasticIn,
      ),
    );
  }

  void _badgeShopCartAnimationPlay() async {
    await _badgeShopCartAnimationController.forward();
    await _badgeShopCartAnimationController.reverse();
  }
}