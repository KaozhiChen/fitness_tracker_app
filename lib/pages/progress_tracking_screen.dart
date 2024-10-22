import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_helper.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressTrackingScreen extends StatefulWidget {
  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> progressData = [];

  @override
  void initState() {
    super.initState();
    _fetchProgressData();
  }

  _fetchProgressData() async {
    final db = await _dbHelper.database;
    var result = await db.query('progress');
    setState(() {
      progressData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress Tracking')),
      body: Column(
        children: [
          SizedBox(height: 300, child: _buildProgressChart()),
          Expanded(
            child: ListView.builder(
              itemCount: progressData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Date: ${progressData[index]['date']}'),
                  subtitle: Text('Calories burned: ${progressData[index]['calories']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChart() {
    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: progressData
              .map((data) =>
                  FlSpot(data['date'].toDouble(), data['calories'].toDouble()))
              .toList(),
        ),
      ],
    ));
  }
}
