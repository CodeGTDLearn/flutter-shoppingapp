import 'package:flutter/widgets.dart';

import '../../../modules/inventory/entity/product.dart';

abstract class ICustomGridtile {
  Widget create(
    final context,
    final Product product,
    final String index,
  );
}