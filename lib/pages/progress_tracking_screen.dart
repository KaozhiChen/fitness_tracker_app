import 'package:flutter/material.dart';
import '../services/calendar.dart';
import '../services/progress_tracker.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 30, 20),
          child: Align(
            alignment: Alignment.topRight,
          ),
        ),
        // Embed Calendar widget
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Calendar(today: today),
          ),
        ),
        // Embed ProgressTracker widget
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 40),
            child: ProgressTracker(),
          ),
        ),
      ],
    );
  }
}
