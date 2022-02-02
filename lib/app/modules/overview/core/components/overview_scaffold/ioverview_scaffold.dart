import 'package:flutter/widgets.dart';

import '../../../controller/overview_controller.dart';

abstract class IOverviewScaffold {
  Widget overviewScaffold(
    final drawer,
    final OverviewController controller,
    final appbar,
  );
}