set parameter=%1

flutter drive ^
--driver=test/flutter_integration_config/driver.dart ^
--target=test/app_driver_test.dart ^
--dart-define=myVar="%parameter%"