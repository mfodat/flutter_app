import 'package:flutter/material.dart';
import '../app/page/login.dart';
import '../app/page/about.dart';
import '../pages/not_found_page.dart';
import '../pages/settings_page.dart';
import '../router/route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
      //  return MaterialPageRoute(builder: (_) => HomePage());
        return MaterialPageRoute(builder: (_) => Login());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
