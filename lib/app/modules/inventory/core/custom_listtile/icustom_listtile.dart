import 'package:flutter/material.dart';

import '../../../../modules/inventory/entity/product.dart';

abstract class ICustomListTile {
  Widget customListTile(Product product);
}