import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_indicator.dart';
import '../../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../controller/overview_controller.dart';
import '../custom_gridview/staggered_gridview.dart';
import '../overview_appbar/filter_options.dart';
import '../overview_appbar/overview_appbar.dart';

class OverviewSimpleScaffold extends StatelessWidget {
  final _simpleAppbar = Get.find<OverviewAppBar>();
  final _controller = Get.find<OverviewController>();
  final drawer;
  final Key scaffoldKey;

  OverviewSimpleScaffold({
    required this.drawer,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    _controller.applyPopupFilter(FilterOptions.All);
    return Scaffold(
        key: scaffoldKey,
        appBar: _simpleAppbar,
        drawer: drawer,
        body: Obx(
          () => _controller.overviewViewGridViewItemsObs.isEmpty
              ? SingleChildScrollView(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      CustomIndicator.message(message: NO_PROD, fontSize: 20)
                    ])))
              : StaggeredGridview()
                  .create(2, _controller.overviewViewGridViewItemsObs.value),
        ));
  }
}