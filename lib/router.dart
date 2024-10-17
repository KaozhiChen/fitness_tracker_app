import 'package:fitness_tracker_app/pages/login_page.dart';
import 'package:fitness_tracker_app/pages/root_app.dart';
import 'package:fitness_tracker_app/pages/signup_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings setting) {
  switch (setting.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case '/signup':
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    case '/root_app':
      return MaterialPageRoute(builder: (context) => const RootApp());
    default:
      return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Page not found'))));
  }
}
