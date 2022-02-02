import 'package:flutter_test/flutter_test.dart';

import '../../../config/app_tests_properties.dart';
import '../../modules/overview/components/custom_appbar_test.dart';
import '../test_titles/custom_appbar_test_titles.dart';

class CustomAppbarTestGroups {
  void groups({required skipGroup}) {
    group(
      CustomAppbarTestTitles.GROUP_TITLE,
      CustomAppbarTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}