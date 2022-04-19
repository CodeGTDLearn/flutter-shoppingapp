import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/components/snackbar/core_snackbar.dart';
import '../../../core/texts/core_labels.dart';
import '../../inventory/entity/product.dart';
import '../../orders/entity/order.dart';
import '../../orders/service/i_orders_service.dart';
import '../core/cart_labels.dart';
import '../entity/cart_item.dart';
import '../service/i_cart_service.dart';

class CartController extends GetxController with GetSingleTickerProviderStateMixin {
  final ICartService cartService;
  final IOrdersService ordersService;
  late AnimationController _badgeShopCartAnimationController;
  late Animation badgeShopCartAnimation;
  final _labels = Get.find<CartLabels>();
  final _coreLabels = Get.find<CoreLabels>();

  var redrawListCartObs = true.obs;
  var qtdeCartItemsObs = 0.obs;
  var amountCartItemsObs = 0.0.obs;
  var availableItemsLabelInOverviewItemDetailsObs = 0.obs;

  CartController({
    required this.cartService,
    required this.ordersService,
  });

  @override
  void onInit() {
    reloadQuantityAndAmountCart();
    _badgeShopCartAnimationSetup();
    super.onInit();
  }

  Map<String, CartItem> getAllCartItems() {
    return cartService.getAllCartItems();
  }

  void addCartItem(Product product) {
    var price = product.price;
    var stockQtde = product.stockQtde;
    var cartItemQtde = cartService.getCartItemQtdeById(product.id!);

    if (stockQtde > cartItemQtde) {
      cartService.addCartItem(product);
      _badgeAnimationPlay();
      reloadQuantityAndAmountCart();
      var remainingStockItems = stockQtde - cartService.getCartItemQtdeById(product.id!);
      availableItemsLabelInOverviewItemDetailsObs.value = remainingStockItems;
      if (stockQtde < 1) amountCartItemsObs.value = amountCartItemsObs.value - price;
    }

    if (stockQtde == cartItemQtde) {
      CoreSnackbar().show(_coreLabels.attent, _labels.noCartItemProductInStock);
    }

    redrawListCart();
  }

  void removeCartItemById(Product product) {
    var cartItemQtde = cartService.getCartItemQtdeById(product.id!);
    var cartItem;
    var price;
    var stockQtde;
    var remainingStock;

    if(cartItemQtde != 0){
      cartItem = cartService.getCartItemById(product.id!);
      price = cartItem.price;
      stockQtde = product.stockQtde;
      remainingStock = 0;
    }

    if (cartItemQtde > 0) {
      cartService.removeCartItemById(product.id!);
      _badgeAnimationPlay();
      reloadQuantityAndAmountCart();
      remainingStock = stockQtde - (--cartItemQtde);
      availableItemsLabelInOverviewItemDetailsObs.value = remainingStock;
      if (stockQtde < 1) amountCartItemsObs.value = amountCartItemsObs.value - price;
      if (stockQtde == remainingStock) removeCartItem(cartItem);
    }

    if (cartItemQtde == 0) {
      CoreSnackbar().show(_coreLabels.attent, _labels.cartItemAbsent);
    }

    redrawListCart();
  }

  void addCartItemUndo(Product product) {
    cartService.addCartItemUndo(product);
    reloadQuantityAndAmountCart();
  }

  void reloadQuantityAndAmountCart() {
    var allCartItems = cartService.getAllCartItems();
    qtdeCartItemsObs.value = cartService.qtdeCartItems(allCartItems);

    var availableCartItems = cartService.getAllCartItems();
    amountCartItemsObs.value = cartService.amountCartItems(availableCartItems);
  }

  void reloadAvailableCartItemsQuantityAndAmount(Map<String, CartItem> cartItems) {
    amountCartItemsObs.value = cartService.amountCartItems(cartItems);
    qtdeCartItemsObs.value = cartService.qtdeCartItems(cartItems);
  }

  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    reloadQuantityAndAmountCart();
  }

  void redrawListCart() {
    redrawListCartObs.value = !redrawListCartObs.value;
  }

  void clearCart() {
    cartService.clearCart();
    reloadQuantityAndAmountCart();
    redrawListCart();
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

  int getCartItemQtdeById(String cartItemId) {
    return cartService.getCartItemQtdeById(cartItemId);
  }
}