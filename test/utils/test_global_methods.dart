import 'package:get/get.dart';

import '../config/tests_config.dart';
import 'db_test_utils.dart';

class TestGlobalMethods {
  void globalSetUpAll(String testModuleName) async {
    print(_headerGenerator(
      module: testModuleName,
      label: 'Starting FunctionalTests: ',
      fullLength: 73,
      qtdeSuperiorLine: 2,
      lineCharacter: '=',
    ));
  }

  void globalTearDownAll(String testModuleName, bool isWidgetTest) async {
    print('\n'
        '<<=============================================================<<\n'
        '<<=============================================================<<\n'
        '<<==<< FunctionalTests Finished: $testModuleName \n'
        '<<=============================================================<<\n'
        '<<=============================================================<<\n'
        '\n \n \n');

    if (!isWidgetTest) {
      var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
      await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      Get.delete(tag: 'dbInstance');
    }

    Get.reset;
  }

  void globalSetUp() {
    var label = "Test Starting...";
    print('\n'
        '>---------------------------------------------------------------------------'
        '----------------->\n'
        '>----------------->    $label >----------------->\n');
  }

  void globalTearDown() {
    var label = "...Test Finished";
    print('\n'
        '<-----------------< $label    <-----------------<\n'
        '<----------------------------------------------------------------------------'
        '----------------<'
        '\n\n\n');
    Get.reset;
  }

  String _headerGenerator({
    required String module,
    required String label,
    required String lineCharacter,
    required int fullLength,
    required int qtdeSuperiorLine,
  }) {
    var title = '$label $module';
    var arrowChar = '>';
    var superiorLine = arrowChar;
    var middleLine = arrowChar;
    for (var i = 0; i < fullLength; i++) {
      superiorLine = "$superiorLine=";
    }

    superiorLine = '$superiorLine$arrowChar\n';
    var middleLength = fullLength / 8;

    for (var i = 0; i < middleLength.toInt(); i++) {
      middleLine = "$middleLine$lineCharacter";
    }
    middleLine = middleLine + arrowChar;

    for (var i = 1; i < qtdeSuperiorLine; i++) {
      superiorLine = "$superiorLine${"$superiorLine"}";
    }
    // var middle = '$middleLine $title $middleLine';
    var middle = '$middleLine $title';
    var footer = '\n$superiorLine\n \n';

    return '$superiorLine$middle$footer';
  }
}
