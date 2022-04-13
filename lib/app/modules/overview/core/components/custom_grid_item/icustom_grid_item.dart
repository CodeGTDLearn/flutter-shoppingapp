import 'package:flutter/widgets.dart';

import '../../../../inventory/entity/product.dart';
import '../../../controller/overview_controller.dart';

abstract class ICustomGridtile {
  Widget gridItemAnimation(
    final context,
    final Product product,
    final String index,
    final OverviewController uniqueController,
  );
}