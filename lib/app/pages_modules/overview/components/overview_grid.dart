import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/overview_controller.dart';
import 'overview_grid_item.dart';
import 'popup_appbar_enum.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final Popup _enumFilter;
  final OverviewController _controller = Get.find();

  OverviewGrid(this._enumFilter);

  @override
  Widget build(BuildContext context) {
    _controller.getProductsByFilter(_enumFilter);
    return Obx(
      () => _controller.filteredProducts.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _controller.filteredProducts.length,
              itemBuilder: (ctx, item) =>
                  OverviewGridItem(_controller.filteredProducts[item]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            ),
    );
  }
}
