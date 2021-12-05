import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/properties/app_routes.dart';

import '../../../core/custom_widgets/custom_appbar.dart';
import '../../../core/keys/overview_keys.dart';
import '../../../core/utils/animations_utils.dart';
import '../../../core/utils/ui_utils.dart';
import '../controller/overview_controller.dart';

// ignore: must_be_immutable
class OverviewItemDetailsView extends StatelessWidget {
  String? _id;

  final _controller = Get.find<OverviewController>();
  final _animations = Get.find<AnimationsUtils>();
  final _appbar = Get.find<CustomAppBar>();
  final _uiUtils = Get.find<UiUtils>();

  OverviewItemDetailsView([this._id]);

  @override
  Widget build(BuildContext context) {
    if (_id == null) _id = Get.parameters['id'];
    var _item = _controller.getProductById(_id!);
    // var _appBar = _appbar.create(_item.title, Get.back);
    var _appBar = _appbar.create(_item.title, () => Get.offNamed(AppRoutes.OVERVIEW_ALL));
    var _appbarZoomPage = _appbar.create(
      _item.title,
      _controller.toggleOverviewItemDetailsImageZoomObs,
      icon: Icons.zoom_out,
    );
    var _height = _uiUtils.usefulHeight(context, _appBar);

    return Obx(() => Scaffold(
        appBar:
            _controller.overviewItemDetailsImageZoomObs.value ? _appbarZoomPage : _appBar,
        body: _animations.zoomPageTransitionSwitcher(
            reverse: !_controller.overviewItemDetailsImageZoomObs.value,
            milliseconds: 1000,
            zoomObservable: _controller.overviewItemDetailsImageZoomObs,
            title: _item.title,
            imageUrl: _item.imageUrl,
            observableToggleMethod: _controller.toggleOverviewItemDetailsImageZoomObs,
            closeBuilder: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Container(
                          height: _height * 0.4,
                          width: double.infinity,
                          child: GestureDetector(
                              onTap: _controller.toggleOverviewItemDetailsImageZoomObs,
                              child: Image.network(_item.imageUrl,
                                  fit: BoxFit.cover, key: Key(K_OV_ITM_DET_PAGE_IMG)))),
                      SizedBox(height: _height * 0.03),
                      Text('\$${_item.title}',
                          style: TextStyle(fontSize: _height * 0.03)),
                      SizedBox(height: _height * 0.03),
                      Text('\$${_item.price}',
                          style: TextStyle(fontSize: _height * 0.03)),
                      SizedBox(height: _height * 0.03),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: _height * 0.4,
                          width: double.infinity,
                          child: Text(_item.description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2))
                    ]))))));
  }
}