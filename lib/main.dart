import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_driver.dart';
import 'shared/app_module.dart';

//void main() => runApp(AppDriver());

void main() => runApp(ModularApp(module: AppModule()));