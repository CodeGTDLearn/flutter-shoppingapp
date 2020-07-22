import 'package:get/get.dart';

import '../../core/entities/cart_item.dart';
import '../../core/entities/product.dart';
import '../repo/i_cart_repo.dart';
import 'i_cart_service.dart';

class CartService implements ICartService {
  final ICartRepo _repo = Get.find();

  @override
  Map<String, CartItem> getAllCartItems() {
    return _repo.getAll();
  }

  @override
  bool addCartItem(Product product) {
    _repo.addProductInTheCart(product);
    return true;
  }

  @override
  bool addCartItemUndo(Product product) {
    _repo.undoAddProductInTheCart(product);
    return false;
  }

  @override
  void removeCartItem(CartItem cartItem) {
    _repo.removeCartItem(cartItem);
  }

  @override
  void clearCart() {
    _repo.clearCartItems();
  }

  @override
  double cartItemTotal$Amount() {
    var total = 0.0;
    getAllCartItems().forEach((key, cartItem) {
      total += cartItem.price * cartItem.qtde;
    });
    return total;
  }

  @override
  int cartItemsQtde() {
    var totalQtde = 0;
    getAllCartItems().forEach((x, item) => totalQtde += item.qtde);
    return totalQtde;
  }
}
