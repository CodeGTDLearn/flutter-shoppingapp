import 'package:flutter/widgets.dart';

import '../../../entity/product.dart';

abstract class ICustomInventoryListview {
  Widget inventoryListview(List<Product> products);
}