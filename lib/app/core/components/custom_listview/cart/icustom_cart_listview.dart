import 'package:flutter/widgets.dart';

import '../../../../modules/cart/entity/cart_item.dart';

abstract class ICustomCartListview {
  Widget create(Map<String, CartItem> mapCartItems);
}