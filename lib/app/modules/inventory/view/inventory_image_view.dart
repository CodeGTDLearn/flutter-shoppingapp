import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/appbar/custom_appbar.dart';


// ignore: must_be_immutable
class InventoryImageView extends StatelessWidget {
  final String? title;
  final String? imageUrl;

  final _appbar = Get.find<CustomAppBar>();

  InventoryImageView([this.title, this.imageUrl]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar.create(title!, Get.back, icon: Icons.zoom_out),
        body: GestureDetector(
            onTap: Get.back,
            child: InteractiveViewer(
                minScale: 0.2,
                maxScale: 100.2,
                child: Image.network(
                  imageUrl!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))));
  }
}