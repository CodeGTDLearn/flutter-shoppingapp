import 'package:shopingapp/entities_models/cart_item.dart';

abstract class ICartRepo {
  Map<String, CartItem> getAll();
}
