import 'package:flutter/widgets.dart';

import '../../controller/overview_controller.dart';

abstract class ICustomScaffold {
  Widget customScaffold(
    final drawer,
    final OverviewController controller,
    final appbar,
  );
}