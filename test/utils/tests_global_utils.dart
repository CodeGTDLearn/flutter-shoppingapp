import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/get_core.dart';

class TestsGlobalUtils {
  void globalSetUpAll({
    required String testModuleName,
    String label = 'Functional-Test | Starting | ',
  }) async {
    print(_classTestHeaderGenerator(
        module: testModuleName,
        label: label,
        fullLength: 150,
        qtdeMarginLines: 2,
        lineCharacter: '='));
  }

  void globalTearDownAll({
    required String testModuleName,
    String label = 'Functional-Test | Finished | ',
    bool? isWidgetTest,
  }) async {
    // isWidgetTest = isWidgetTest ?? true;

    print(_classTestHeaderGenerator(
        module: testModuleName,
        label: label,
        fullLength: 150,
        qtdeMarginLines: 2,
        lineCharacter: '='));

    // if (isWidgetTest == false) {
    //   var dbTestUtils = Get.put(DbTestUtils(), tag: 'dbInstance');
    //   await dbTestUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
    //   Get.delete(tag: 'dbInstance');
    // }

    Get.reset;
  }

  void globalSetUp() {
    print(_methodTestHeaderGenerator(
        label: "Test Starting...",
        lineCharacter: '-',
        arrowChar: '>',
        fullLength: 100,
        qtdeMarginLines: 1,
        startingHeader: true));
  }

  void globalTearDown() {
    print(_methodTestHeaderGenerator(
        label: "...Test Finished",
        lineCharacter: '-',
        arrowChar: '<',
        fullLength: 100,
        qtdeMarginLines: 1,
        startingHeader: false));

    Get.reset;
  }

  String _classTestHeaderGenerator({
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

  String _methodTestHeaderGenerator({
    required String label,
    required String lineCharacter,
    required int fullLength,
    required int qtdeMarginLines,
    required String arrowChar,
    required bool startingHeader,
  }) {
    var superiorLine = arrowChar;
    var middleLine = arrowChar;

    for (var i = 0; i < fullLength; i++) {
      superiorLine = "$superiorLine$lineCharacter";
    }
    superiorLine = '$superiorLine$arrowChar\n';

    var middleLength = fullLength / 6;

    for (var i = 0; i < middleLength.toInt(); i++) {
      middleLine = "$middleLine$lineCharacter";
    }
    middleLine = middleLine + arrowChar;

    for (var i = 1; i < qtdeMarginLines; i++) {
      superiorLine = "$superiorLine${"$superiorLine"}";
    }
    var middleStart = '$middleLine '
        '${startingHeader ? '   ' : ''} '
        '$label '
        '${startingHeader ? '' : '   '}'
        '$middleLine\n';

    return startingHeader
        ? '\n$superiorLine$middleStart'
        : '$middleStart$superiorLine\n\n\n';
  }
}