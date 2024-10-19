import 'package:flutter/material.dart';
import 'router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker App',
      initialRoute: '/login',
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
      ),
    );
  }
}
