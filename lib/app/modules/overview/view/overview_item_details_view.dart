import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/keys/overview_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/utils/utils.dart';
import '../controller/overview_controller.dart';

// ignore: must_be_immutable
class OverviewItemDetailsView extends StatelessWidget {
  String? _id;

  final _controller = Get.find<OverviewController>();

  OverviewItemDetailsView([this._id]);

  @override
  Widget build(BuildContext context) {
    if (_id == null) _id = Get.parameters['id'];
    var _item = _controller.getProductById(_id!);
    var _appBar = AppBar(title: Text(_item.title));
    var _appBarZoom = AppBar(title: Text(_item.title), automaticallyImplyLeading: false);
    var _height = Utils.usefulHeight(context, _appBar);
    return Obx(() => Scaffold(
        appBar: _controller.overviewDetailsImageZoomObs.value ? _appBarZoom : _appBar,
        body: PageTransitionSwitcher(
            duration: Duration(milliseconds: DELAY_MILLISEC_GRIDVIEW),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return SharedAxisTransition(
                  child: child,
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.scaled,
                  fillColor: Colors.white);
            },
            child: _controller.overviewDetailsImageZoomObs.value
                ? GestureDetector(
                    onTap: _controller.toggleOverviewDetailsImageZoom,
                    child: InteractiveViewer(
                        minScale: 0.2,
                        maxScale: 100.2,
                        child: Image.network(_item.imageUrl,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover)))
                : SingleChildScrollView(
                    child: Column(children: [
                    Container(
                        height: _height * 0.4,
                        width: double.infinity,
                        child: GestureDetector(
                            onTap: _controller.toggleOverviewDetailsImageZoom,
                            child: Image.network(_item.imageUrl,
                                fit: BoxFit.cover, key: Key(K_OV_ITM_DET_PAGE_IMG)))),
                    SizedBox(height: _height * 0.03),
                    Text('\$${_item.title}', style: TextStyle(fontSize: _height * 0.03)),
                    SizedBox(height: _height * 0.03),
                    Text('\$${_item.price}', style: TextStyle(fontSize: _height * 0.03)),
                    SizedBox(height: _height * 0.03),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: _height * 0.4,
                        width: double.infinity,
                        child: Text(_item.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2))
                  ])))));
  }
}
// DO NOT REMOVE
// GetPage(
//   name: '$OVERVIEW_DETAIL',
//   page: () => OverviewItemDetailsView(),
// ),
// Get.toNamed('$OVERVIEW_DETAIL_ROUTE${_product.id}'),
// String? id = Get.arguments;