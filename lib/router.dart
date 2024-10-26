import 'package:fitness_tracker_app/pages/login_page.dart';
import 'package:fitness_tracker_app/pages/root_app.dart';
import 'package:fitness_tracker_app/pages/welcome_page.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings setting) {
  switch (setting.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case '/welcome':
      return MaterialPageRoute(builder: (context) => const WelcomePage());
    case '/root_app':
      return MaterialPageRoute(builder: (context) => const RootApp());

    default:
      return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Page not found'))));
  }
}
