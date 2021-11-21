import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../inventory/entity/product.dart';
import '../controller/overview_controller.dart';
import 'custom_griditem/simple_gridtile.dart';

class GridItem extends StatelessWidget {
  final Product _product;

  final _uniqueController = OverviewController(service: Get.find());

  final String index;

  GridItem(this._product, this.index);

  @override
  Widget build(BuildContext context) {
    _uniqueController.favoriteStatusObs.value = _product.isFavorite;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
            borderRadius: BorderRadius.circular(10.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: SimpleGridtile().create(
            context,
            _product,
            index,
            _uniqueController,
          ),
        ));
  }
}