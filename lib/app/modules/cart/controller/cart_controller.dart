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

  var renderListViewObs = true.obs;
  var qtdeCartItemsObs = 0.obs;
  var amountCartItemsObs = 0.0.obs;

  CartController({
    required this.cartService,
    required this.ordersService,
  });

  @override
  void onInit() {
    reloadQtdeAndAmountCart(getAllCartItems());
    super.onInit();
    _badgeShopCartAnimationSetup();
  }

  Map<String, CartItem> getAllCartItems() {
    return cartService.getAllCartItems();
  }

  void addCartItem(Product product) {
    var price = product.price;
    var stockQtde = product.stockQtde;

    cartService.addCartItem(product);
    _badgeAnimationPlay();
    renderListViewObs.value = !renderListViewObs.value;
    reloadQtdeAndAmountCart(getAllCartItems());
    if (stockQtde < 1) amountCartItemsObs.value = amountCartItemsObs.value - price;
  }

  void addCartItemUndo(Product product) {
    cartService.addCartItemUndo(product);
    reloadQtdeAndAmountCart(getAllCartItems());
  }

  void reloadQtdeAndAmountCart(Map<String, CartItem> cartItems) {
    var cartItems = cartService.getAllCartItems();
    amountCartItemsObs.value = cartService.amountCartItems(cartItems);
    qtdeCartItemsObs.value = cartService.qtdeCartItems(cartItems);
  }

  void reloadQtdeAndAmountCartAvailableItems(Map<String, CartItem> cartItems) {
    amountCartItemsObs.value = cartService.amountCartItems(cartItems);
    qtdeCartItemsObs.value = cartService.qtdeCartItems(cartItems);
  }

  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    reloadQtdeAndAmountCart(getAllCartItems());
  }

  void clearCart() {
    cartService.clearCart();
    reloadQtdeAndAmountCart(getAllCartItems());
  }

  Future<Order> addOrder(List<CartItem> cartItems, double amount) {
    return ordersService
        .addOrder(cartItems, amount)
        .catchError((onError) => throw onError);
  }

  Map<String, CartItem> getAllAvailableCartItems(Map<String, CartItem> cartItems) {
    return cartService.getAllAvailableCartItems(cartItems);
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

  void _badgeAnimationPlay() async {
    await _badgeShopCartAnimationController.forward();
    await _badgeShopCartAnimationController.reverse();
  }
}