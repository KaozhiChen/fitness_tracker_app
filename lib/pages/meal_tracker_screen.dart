import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import 'package:fitness_tracker_app/theme/colors.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final TextEditingController _calorieController = TextEditingController(); // Controller for manual calorie input
  bool databaseUpdated = false; // Indicates if the database was updated

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            chooseInputMethod(),
          ],
        ),
      ),
    );
  }

  // Setup to display the input form for manually entering calories
  Widget chooseInputMethod() {
    return Column(
      children: [
        const SizedBox(height: 75),
        // Display appropriate message based on whether the database was updated
        databaseUpdated
            ? const Center(
                child: Text('Calories added to database.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)))
            : const Center(
                child: Text('Enter your calories.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        const SizedBox(height: 20),
        manualCalorieInput(),
      ],
    );
  }

  // Widget to handle manual calorie input
  Widget manualCalorieInput() {
    return Column(
      children: [
        const SizedBox(height: 30), // Increased space between label and input field
        SizedBox(
          width: 337.1,
          child: Material(
            elevation: 10,
            shadowColor: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFe9e6df),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _calorieController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Calories Here",
                hintStyle: TextStyle(color: Color.fromARGB(255, 131, 129, 125)),
                              ),
              validator: (value) {
                if (value == null) {
                  return null;
                }
                // Validate if the input is a valid number
                if (int.tryParse(value) is! int) {
                  return 'Please enter your calories.';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 20), // Space between input field and submit button
        buttonTemplate(() {
          if (_calorieController.text.isNotEmpty) {
            addCaloriesToDatabase(_calorieController.text);
            setState(() {
              databaseUpdated = true;
            });
            showSnackBar();
            _calorieController.clear();
          }
        }, 'Submit Calories'),
      ],
    );
  }

  // Template for buttons used throughout the UI
  Widget buttonTemplate(VoidCallback onPressed, String text) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to add the manually entered calories to the database
  void addCaloriesToDatabase(String calories) async {
    await DatabaseHelper.instance.incrementCaloriesForDay(DateTime.now().day,
        DateTime.now().month, DateTime.now().year, int.parse(calories));
  }

  // Function to show a SnackBar message indicating calorie intake has been updated
  void showSnackBar() async {
    final messenger = ScaffoldMessenger.of(context);
    String textForSnackBar;

    // Retrieve the calories for the current day from the database
    int calories = await DatabaseHelper.instance.getCaloriesForDay(
        DateTime.now().day, DateTime.now().month, DateTime.now().year);
        
    textForSnackBar = (calories >= 0) ? 'Calorie Intake Updated!' : 'Error';
    
    messenger.showSnackBar(
      SnackBar(
        content: Text(textForSnackBar),
      ),
    );
  }
}
