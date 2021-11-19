import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_overview_griditem/overview_griditem_simple_gridtile.dart';
import '../../inventory/entity/product.dart';
import '../controller/overview_controller.dart';

class OverviewGridItem extends StatelessWidget {
  final Product _product;
  final OverviewController _overviewController = OverviewController(service: Get.find());
  final String index;

  OverviewGridItem(this._product, this.index);

  @override
  Widget build(BuildContext context) {
    _overviewController.favoriteStatusObs.value = _product.isFavorite;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
            borderRadius: BorderRadius.circular(10.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: OverviewGriditemSimpleGridtile().create(
            context,
            _product,
            index,
          ),
        ));
  }
}