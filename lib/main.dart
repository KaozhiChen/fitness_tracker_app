import 'package:fitness_tracker_app/pages/root_app.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker App',
      initialRoute: '/root_app',
      onGenerateRoute: router.generateRoute,
    );
  }
}
