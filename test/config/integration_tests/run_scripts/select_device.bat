set parameter1=%1
set parameter2=%2

ECHO FOR NOW, 'FLUTTER DRIVE' DOES NOT RUN THE TESTS
ECHO IN MULTIPLE DEVICES PARALLELLY 'YET'.
ECHO https://github.com/flutter/flutter/issues/63037
flutter drive ^
--device-id %parameter1% ^
--driver=test/config/integration_tests/driver.dart ^
--target=test/app_driver_test.dart ^
--dart-define=testType="%parameter2%"
