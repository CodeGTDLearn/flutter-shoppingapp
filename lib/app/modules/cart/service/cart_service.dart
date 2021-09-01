import '../../inventory/entity/product.dart';
import '../entity/cart_item.dart';
import '../repo/i_cart_repo.dart';
import 'i_cart_service.dart';

class CartService implements ICartService {
  final ICartRepo repo;

  CartService({required this.repo});

  Map<String, CartItem> getAllCartItems() {
    return repo.getAllCartItems();
  }

  bool addCartItem(Product product) {
    repo.addCartItem(product);
    return true;
  }

  bool addCartItemUndo(Product product) {
    repo.addCartItemUndo(product);
    return false;
  }

  void removeCartItem(CartItem cartItem) {
    repo.removeCartItem(cartItem);
  }

  void clearCart() {
    repo.clearCart();
  }

  double cartItemTotal$Amount() {
    var total = 0.0;
    getAllCartItems().forEach((key, cartItem) {
      total += cartItem.price * cartItem.qtde;
    });
    return total;
  }

  int cartItemsQtde() {
    var totalQtde = 0;
    getAllCartItems().forEach((x, item) => totalQtde += item.qtde);
    return totalQtde;
  }
}
