set parameter1=%1
set parameter2=%2

flutter drive ^
-d %parameter1% ^
--driver=test/flutter_integration/driver.dart ^
--target=test/app_driver_test.dart ^
--dart-define=testType="%parameter2%"
