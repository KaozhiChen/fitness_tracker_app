import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_helper.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> meals = [];

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  _fetchMeals() async {
    final db = await _dbHelper.database;
    var result = await db.query('meals');
    setState(() {
      meals = result;
    });
  }

  _logMeal(String meal) async {
    final db = await _dbHelper.database;
    await db.insert('meals', {'name': meal, 'calories': 250});
    _fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Planner')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Log meal',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _logMeal(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(meals[index]['name']),
                  subtitle: Text('${meals[index]['calories']} calories'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
