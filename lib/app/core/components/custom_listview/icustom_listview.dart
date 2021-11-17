import 'package:flutter/widgets.dart';

import '../../../modules/cart/entity/cart_item.dart';

abstract class ICustomListview {
  Widget create(Map<String, CartItem> listItems);
}