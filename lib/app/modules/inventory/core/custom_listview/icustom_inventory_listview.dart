import 'package:flutter/widgets.dart';

import '../../../../modules/inventory/entity/product.dart';

abstract class ICustomInventoryListview {
  Widget create(List<Product> productsList);
}