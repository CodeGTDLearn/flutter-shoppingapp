import 'package:get/get.dart';

class TestsGlobalUtils {
  void globalSetUpAll({
    required String testModuleName,
    String label = 'Functional-Test | Starting | ',
  }) async {
    print(_headerGenerator(
      module: testModuleName,
      label: label,
      fullLength: 150,
      qtdeMarginLines: 2,
      lineCharacter: '=',
    ));
  }

  void globalTearDownAll({
    required String testModuleName,
    String label = 'Functional-Test | Finished | ',
    bool? isWidgetTest,
  }) async {
    isWidgetTest = isWidgetTest ?? true;

    print(_headerGenerator(
      module: testModuleName,
      label: label,
      fullLength: 150,
      qtdeMarginLines: 2,
      lineCharacter: '=',
    ));

    // if (isWidgetTest == false) {
    //   var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    //   await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
    //   Get.delete(tag: 'dbInstance');
    // }

    Get.reset;
  }

  void globalSetUp() {
    // todo: Automatize such as _headerGenerator
    var label = "Test Starting...";
    print('\n'
        '>---------------------------------------------------------------------------'
        '----------------->\n'
        '>----------------->    $label >----------------->\n');
  }

  void globalTearDown() {
    // todo: Automatize such as _headerGenerator
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
    required int qtdeMarginLines,
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

    for (var i = 1; i < qtdeMarginLines; i++) {
      superiorLine = "$superiorLine${"$superiorLine"}";
    }
    // var middle = '$middleLine $title $middleLine';
    var middle = '$middleLine $title';
    var footer = '\n$superiorLine\n \n';

    return '$superiorLine$middle$footer';
  }
}
