import 'package:fitness_tracker_app/pages/home_page.dart';
import 'package:fitness_tracker_app/pages/profile.dart';
import 'package:fitness_tracker_app/theme/colors.dart';
import 'package:fitness_tracker_app/pages/workout_tracker_screen.dart';
import 'package:fitness_tracker_app/pages/meal_planner_screen.dart';
import 'package:fitness_tracker_app/pages/progress_tracking_screen.dart';
import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        meals_progress_workouts
        children: [
          // here to display different pages, do this like home page
          // the order of pages should be consistent with the navigation order
          HomePage(),
          WorkoutTrackerScreen(),
          ProgressTrackingScreen(),
          MealPlannerScreen(),
          Center(child: Text('Chart Page')),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        selectedItemColor: thirdColor,
        unselectedItemColor: secondary,
        enableFeedback: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}