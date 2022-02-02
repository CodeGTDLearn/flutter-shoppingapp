import 'package:flutter/material.dart';

import '../../../entity/product.dart';

abstract class ICustomListTile {
  Widget customListTile(Product product);
}