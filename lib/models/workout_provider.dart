import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class WorkoutProvider with ChangeNotifier {
  int workoutsCompleted = 0;
  double caloriesBurned = 0.0;

  Future<void> loadDailyData(int day, int month, int year) async {
    workoutsCompleted = await _getCompletedWorkouts(day, month, year);
    caloriesBurned = await _getCaloriesBurned(day, month, year);
    notifyListeners();
  }

  // get completed workouts
  Future<int> _getCompletedWorkouts(int day, int month, int year) async {
    final events =
        await DatabaseHelper.instance.queryEventsforDay(day, month, year);
    return events.where((event) => event['caloriesBurned'] > 0).length;
  }

  // get burned calories
  Future<double> _getCaloriesBurned(int day, int month, int year) async {
    final events =
        await DatabaseHelper.instance.queryEventsforDay(day, month, year);
    return events.fold<double>(
        0.0, (sum, event) => sum + (event['caloriesBurned'] ?? 0.0));
  }

  //
  // Future<void> addIntake(double calories, int day, int month, int year) async {
  //   await DatabaseHelper.instance
  //       .incrementCaloriesForDay(day, month, year, calories.toInt());
  //   await loadDailyData(day, month, year);
  // }

  Future<void> completeWorkout(
      double calories, int day, int month, int year) async {
    await DatabaseHelper.instance.setCaloriesBurnedForWorkout(
        'workoutName', 'workoutMuscle', day, month, year, calories);
    await loadDailyData(day, month, year);
  }
}
