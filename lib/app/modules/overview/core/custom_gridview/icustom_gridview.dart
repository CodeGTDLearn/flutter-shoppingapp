import 'package:flutter/widgets.dart';

import '../../../inventory/entity/product.dart';

abstract class ICustomGridview {
  Widget create(
    int columnCount,
    List<Product> gridItems, [
    int delayMilliseconds,
  ]);
}