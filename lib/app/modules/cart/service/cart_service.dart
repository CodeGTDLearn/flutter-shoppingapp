import 'package:get/get.dart';

import '../../overview/product.dart';
import '../cart_item.dart';
import '../repo/cart_firebase_repo.dart';
import '../repo/i_cart_repo.dart';
import 'i_cart_service.dart';

class CartService implements ICartService {
//  final _repo = Modular.get<ICartRepo>();
  final ICartRepo _repo = Get.put(CartFirebaseRepo());

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
