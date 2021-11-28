import 'package:flutter/material.dart';

import '../../../../modules/inventory/entity/product.dart';

abstract class ICustomInventoryListtile {
  Widget create(Product product);
}