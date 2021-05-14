set parameter=%1

flutter drive ^
--driver=test/app/modules/orders/view/gui-config/gui_driver.dart ^
--target=test/app_driver_test.dart ^
--dart-define=myVar="%parameter%"