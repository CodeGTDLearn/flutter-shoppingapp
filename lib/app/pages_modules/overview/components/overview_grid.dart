import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/app_messages_provided.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/custom_progress_indicator.dart';

import '../controller/overview_controller.dart';
import 'filter_favorite_enum.dart';
import 'overview_grid_item.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final EnumFilter enumFilter;
  final OverviewController controller;

  OverviewGrid(this.enumFilter, this.controller);

  @override
  Widget build(BuildContext context) {
    controller.getProductsByFilter(enumFilter);
    var height = AppBar().preferredSize.height;

    return Obx(() => controller.filteredProductsObs.length == 0
        ? SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  CustomProgressIndicator.message(message: NO_PROD, fontSize: 20)
                ])),
          )
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: controller.filteredProductsObs.length,
            itemBuilder: (ctx, index) => OverviewGridItem(
                  controller.filteredProductsObs[index],
                  index.toString(),
                ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10)));
  }
}
