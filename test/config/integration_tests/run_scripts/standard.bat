set parameter=%1

flutter drive ^
--driver=test/config/integration_tests/integration_driver.dart ^
--target=test/app_driver_test.dart ^
--dart-define=testType="%parameter%"