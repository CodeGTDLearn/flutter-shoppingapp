set parameter1=%1
set parameter2=%2

::FOR NOW, 'FLUTTER DRIVE' DOES NOT RUN THE TESTS
::IN MULTIPLE DEVICES PARALLELLY 'YET'.
:: https://github.com/flutter/flutter/issues/63037
flutter drive ^
--device-id %parameter1% ^
--driver=test/config/integration_tests/integration_driver.dart ^
--target=test/app_driver_test.dart ^
--dart-define=testType="%parameter2%"