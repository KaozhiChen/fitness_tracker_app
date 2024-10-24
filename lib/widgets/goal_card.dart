import 'package:flutter/material.dart';
import 'package:fitness_tracker_app/theme/colors.dart';

class GoalCard extends StatefulWidget {
  const GoalCard({super.key});

  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  final List<Map<String, dynamic>> _goals =
      []; // Store goals with completion status
  final TextEditingController _goalController = TextEditingController();

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        _goals.add({"text": _goalController.text, "completed": false});
      });
      _goalController.clear();
    }
  }

  void _toggleGoalCompletion(int index) {
    setState(() {
      _goals[index]["completed"] = !_goals[index]["completed"];
    });
  }

  void _removeGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [primary, secondary], // Background gradient color
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Goals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
            const SizedBox(height: 10),
            // Input field to add new goal
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _goalController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: bgTextField,
                      hintText: 'Enter your goal',
                      hintStyle: const TextStyle(color: labelColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: black),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: thirdColor),
                  onPressed: _addGoal,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Display the list of goals
            _goals.isEmpty
                ? const Text(
                    'No goals added yet.',
                    style: TextStyle(color: white),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _goals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          icon: Icon(
                            _goals[index]["completed"]
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: _goals[index]["completed"]
                                ? Colors.green
                                : fourthColor,
                          ),
                          onPressed: () => _toggleGoalCompletion(index),
                        ),
                        title: Text(
                          _goals[index]["text"],
                          style: TextStyle(
                              color: white,
                              decoration: _goals[index]["completed"]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.grey[600]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_forever_rounded,
                              color: Colors.red),
                          onPressed: () => _removeGoal(index),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
