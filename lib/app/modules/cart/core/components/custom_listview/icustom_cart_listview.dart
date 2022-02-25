import 'package:flutter/widgets.dart';

import '../../../entity/cart_item.dart';

abstract class ICustomCartListview {
  Widget listview(Map<String, CartItem> mapCartItems);
}