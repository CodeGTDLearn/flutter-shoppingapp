import 'package:shopingapp/entities_models/cart_item.dart';
import 'package:shopingapp/repositories/i_cart_repo.dart';

class CartRepo implements ICartRepo {
  Map<String, CartItem> _listCartItems = {};

  @override
  Map<String, CartItem> getAll() {
    return {..._listCartItems};
  }
}
