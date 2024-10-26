import 'package:fitness_tracker_app/models/workout_provider.dart';
import 'package:fitness_tracker_app/providers/user_provider.dart';
import 'package:fitness_tracker_app/services/database_helper.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.deleteDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness Tracker App',
        initialRoute: '/welcome',
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
