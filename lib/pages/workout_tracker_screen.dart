import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_helper.dart';

class WorkoutTrackerScreen extends StatefulWidget {
  @override
  _WorkoutTrackerScreenState createState() => _WorkoutTrackerScreenState();
}

class _WorkoutTrackerScreenState extends State<WorkoutTrackerScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> workouts = [];
  String filter = '';

  @override
  void initState() {
    super.initState();
    _fetchWorkouts();
  }

  _fetchWorkouts() async {
    final db = await _dbHelper.database;
    var result = await db.query('workouts');
    setState(() {
      workouts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Tracker')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Filter workouts',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                if (filter.isNotEmpty &&
                    !workouts[index]['name']
                        .toLowerCase()
                        .contains(filter.toLowerCase())) {
                  return Container();
                }
                return ListTile(
                  title: Text(workouts[index]['name']),
                  subtitle: Text('Time: ${workouts[index]['time']} min'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailScreen(workout: workouts[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutDetailScreen extends StatelessWidget {
  final Map<String, dynamic> workout;
  WorkoutDetailScreen({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(workout['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Steps:'),
            SizedBox(height: 8),
            Text(workout['steps']),
            SizedBox(height: 16),
            Text('Time: ${workout['time']} minutes'),
          ],
        ),
      ),
    );
  }
}
