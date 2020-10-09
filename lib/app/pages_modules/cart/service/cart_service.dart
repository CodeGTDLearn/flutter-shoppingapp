import '../../managed_products/entities/product.dart';
import '../entities/cart_item.dart';
import '../repo/i_cart_repo.dart';
import 'i_cart_service.dart';

class CartService implements ICartService {
  final ICartRepo repo;

  CartService({this.repo});

  @override
  Map<String, CartItem> getAllCartItems() {
    return repo.getAll();
  }

  @override
  bool addCartItem(Product product) {
    repo.addProductInTheCart(product);
    return true;
  }

  @override
  bool addCartItemUndo(Product product) {
    repo.undoAddProductInTheCart(product);
    return false;
  }

  @override
  void removeCartItem(CartItem cartItem) {
    repo.removeCartItem(cartItem);
  }

  @override
  void clearCart() {
    repo.clearCart();
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
