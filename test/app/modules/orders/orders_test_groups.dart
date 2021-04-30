import 'package:test/test.dart';

import 'orders_controller_test.dart';
import 'orders_test_config.dart';
import 'view/orders_view_test.dart';
import 'repo/orders_repo_test.dart';
import 'service/orders_service_test.dart';

class OrdersTest {
  static void groups() {
    group("${OrdersTestConfig().REPO_TEST_TITLE}", OrdersRepoTests.unit);
    group("${OrdersTestConfig().SERVICE_TEST_TITLE}", OrdersServiceTests.unit);
    group(
        "${OrdersTestConfig().CONTROLLER_TEST_TITLE}", OrdersControllerTests.integration);
    group("${OrdersTestConfig().VIEW_TEST_TITLE}", OrdersViewTests.functional);
    // group("${OrdersTestConfig().VIEW_TEST_TITLE}", OrdersViewIntTests.);//nao fica aqui
    // isso e executado pelo script
    // achar forma de executar o script pela IDE, ou de executa ra linha de comando de
    // execucao do FLutterIntegrationTest pela IDE
  }
}
