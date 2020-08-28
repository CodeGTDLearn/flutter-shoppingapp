import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import 'filter_favorite_enum.dart';
import 'overview_grid_item.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final EnumFilter _filter;
  final OverviewController _controller = Get.find();

  OverviewGrid(this._filter);

  @override
  Widget build(BuildContext context) {
    _controller.getProductsByFilter(_filter);
    return Obx(
      () => _controller.filteredProductsObs.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _controller.filteredProductsObs.length,
              itemBuilder: (ctx, item) =>
                  OverviewGridItem(_controller.filteredProductsObs[item]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
            ),
    );
  }
}
