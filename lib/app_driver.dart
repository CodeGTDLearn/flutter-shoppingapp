import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'config/appProperties.dart';
import 'config/themes.dart';

class AppDriver extends StatefulWidget {
  @override
  _AppDriverState createState() => _AppDriverState();
}

class _AppDriverState extends State<AppDriver> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: APP_DEB_CHECK,
      title: APP_TITLE,
      theme: AppTheme().theme,
      navigatorKey: Modular.navigatorKey,
      initialRoute: RT_OVERV_VIEW,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
