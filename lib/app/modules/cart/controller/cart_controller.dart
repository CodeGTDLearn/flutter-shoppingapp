import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/texts/core_labels.dart';

import '../../../core/components/snackbar/core_snackbar.dart';
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
    reloadQtdeAndAmountCart();
    _badgeShopCartAnimationSetup();
    super.onInit();
  }

  Map<String, CartItem> getAllCartItems() {
    return cartService.getAllCartItems();
  }

  void addCartItem(Product product) {
    var price = product.price;
    var stockQtde = product.stockQtde;
    var cartItemQtdeById = cartService.getCartItemQtdeById(product.id!);

    if (stockQtde > cartItemQtdeById) {
      cartService.addCartItem(product);
      _badgeAnimationPlay();
      reloadQtdeAndAmountCart();
      availableItemsLabelInOverviewItemDetailsObs.value =
          cartService.getCartItemQtdeById(product.id!);
      if (stockQtde < 1) amountCartItemsObs.value = amountCartItemsObs.value - price;
    }

    if (stockQtde == cartItemQtdeById) {
      CoreSnackbar().show(_coreLabels.attent, _labels.noCartItemProductInStock);
    }
    redrawListCart();
  }


  void removeCartItemById(String cartItemId) {
    if (cartService.getCartItemQtdeById(cartItemId) > 0) {
      cartService.removeCartItemById(cartItemId);
      reloadQtdeAndAmountCart();
    }

    if (cartService.getCartItemQtdeById(cartItemId) == 0) {
      var cartItem = cartService.getCartItemById(cartItemId);
      removeCartItem(cartItem);
      availableItemsLabelInOverviewItemDetailsObs.value =
          cartService.getCartItemQtdeById(cartItemId);
      CoreSnackbar().show(_coreLabels.attent, _labels.noCartItemInTheCart);
    }
    redrawListCart();
  }

  void addCartItemUndo(Product product) {
    cartService.addCartItemUndo(product);
    reloadQtdeAndAmountCart();
  }

  void reloadQtdeAndAmountCart() {
    var allCartItems = cartService.getAllCartItems();
    qtdeCartItemsObs.value = cartService.qtdeCartItems(allCartItems);

    var availableCartItems = cartService.getAllCartItems();
    amountCartItemsObs.value = cartService.amountCartItems(availableCartItems);
  }

  void reloadQtdeAndAmountCartAvailableItems(Map<String, CartItem> cartItems) {
    amountCartItemsObs.value = cartService.amountCartItems(cartItems);
    qtdeCartItemsObs.value = cartService.qtdeCartItems(cartItems);
  }

  void removeCartItem(CartItem cartItem) {
    cartService.removeCartItem(cartItem);
    reloadQtdeAndAmountCart();
  }

  void redrawListCart() {
    redrawListCartObs.value = !redrawListCartObs.value;
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