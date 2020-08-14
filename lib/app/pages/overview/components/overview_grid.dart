import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../pages_texts_icons/pages_generic_texts/messages_db_empty.dart';
import '../controller/overview_controller.dart';
import 'overview_item/overview_item.dart';

// ignore: must_be_immutable
class OverviewGrid extends StatelessWidget {
  final OverviewController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return _controller.filteredProducts.length == 0
        ? Center(child: Text(EMPTY_DB, style: TextStyle(fontSize: 20)))
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
