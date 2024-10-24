import 'package:fitness_tracker_app/providers/user_provider.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness Tracker App',
        initialRoute: '/login',
        onGenerateRoute: router.generateRoute,
        theme: ThemeData(
          splashColor: Colors.transparent,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primary,
            secondary: secondary,
          ),
        ),
      ),
    );
  }
}
