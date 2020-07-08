import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/messages/grid_products.dart';
import '../overview_controller.dart';
import 'overview_item/overview_item.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final OverviewController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return _controller.filteredProducts.length == 0
        ? Center(child: Text(GRID_PRODUCTS_MSG, style: TextStyle(fontSize: 20)))
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: _controller.filteredProducts.length,
            itemBuilder: (ctx, item) =>
                OverviewItem(_controller.filteredProducts[item]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
  }
}
