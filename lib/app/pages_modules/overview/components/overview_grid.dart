import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/overview_controller.dart';
import 'overview_item/overview_item.dart';
import 'popup_appbar_enum.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final Popup _enum;
  final OverviewController _controller = Get.find();

  OverviewGrid(this._enum);

  @override
  Widget build(BuildContext context) {
    _controller.filterProducts(_enum);
    return Obx(
      () => _controller.filteredProducts.length == 0
          ? Center(child: CircularProgressIndicator())
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
            ),
    );
  }
}
