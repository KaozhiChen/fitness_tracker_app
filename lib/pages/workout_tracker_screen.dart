import '../services/database_helper.dart';
import '../services/upperWorkouts.dart';
import 'package:flutter/material.dart';
import '../services/coreWorkouts.dart';
import '../services/lowerWorkouts.dart';
import 'package:duration_picker/duration_picker.dart';
import '../services/calculator.dart';
import '../services/event.dart';
import 'package:fitness_tracker_app/theme/colors.dart';

class WorkoutModel {
  String name, description;
  double
      met; // MET (Metabolic Equivalent of Task) value for calorie calculations
  bool isSelected;

  WorkoutModel(this.name, this.met, this.isSelected, this.description);
}

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cardTextStyle = Theme.of(context).textTheme.displaySmall!.copyWith(
          color: const Color.fromRGBO(255, 255, 255, 1),
          fontSize: 28,
        );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bigCardButton(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpperWorkouts(),
                    ),
                  );
                },
                    Text(
                      'Upper Body Workouts',
                      style: cardTextStyle,
                    )),
                bigCardButton(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LowerWorkouts(),
                      ),
                    );
                  },
                  Text(
                    'Lower Body Workouts',
                    style: cardTextStyle,
                  ),
                ),
                bigCardButton(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CoreWorkouts(),
                    ),
                  );
                },
                    Text(
                      'Core Workouts',
                      style: cardTextStyle,
                    )),
                // Button to calculate calories burned for the current day’s workouts
                bigCardButton(() async {
                  // Querying all workouts for the current day
                  List<Map<String, dynamic>> allWorkouts =
                      await DatabaseHelper.instance.queryEventsforDay(
                          DateTime.now().day,
                          DateTime.now().month,
                          DateTime.now().year);
                  // Getting the user’s weight from the database
                  double userWeight = double.parse(
                      await DatabaseHelper.instance.getUserInfo('weight'));
                  int duration = 0;
                  double met = 0;

                  // Looping through each workout for the day
                  for (int i = 0; i < allWorkouts.length; i++) {
                    // Check if the workout has calories burned set to 0
                    if (allWorkouts[i]['caloriesBurned'] == 0) {
                      // Showing a dialog to get the duration for the workout
                      Duration? time = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              '\n\n\nHow long did you take doing ${allWorkouts[i]['workoutName']}?',
                              style: const TextStyle(
                                  backgroundColor: primary,
                                  color: Color(0xFFe9e6df),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: cardTextStyle,
                            insetPadding: const EdgeInsets.all(0),
                            backgroundColor: Colors.transparent,
                            content: SingleChildScrollView(
                              // Enable scrolling
                              child: SizedBox(
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Duration picker for workout time
                                    DurationPickerDialog(
                                      initialTime: Duration.zero,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFe9e6df),
                                        boxShadow: const [BoxShadow()],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );

                      // If duration is not null and greater than 0
                      if (time != null && time != 0) {
                        duration = time.inMinutes; // Converting time to minutes
                        met = allWorkouts[i]['met']; // Assigning MET value

                        double caloriesBurned = 0;
                        double totalCaloriesBurned = 0;
                        // Calculating calories burned based on user’s weight, duration, and MET
                        caloriesBurned = Calculators()
                            .calcCaloriesBurned(userWeight, duration, met);

                        // Updating the database with the calculated calories burned
                        await DatabaseHelper.instance
                            .setCaloriesBurnedForWorkout(
                                allWorkouts[i]['workoutName'],
                                allWorkouts[i]['workoutMuscle'],
                                allWorkouts[i]['day'],
                                allWorkouts[i]['month'],
                                allWorkouts[i]['year'],
                                caloriesBurned);
                        totalCaloriesBurned += caloriesBurned;
                      }
                    }
                  }
                },
                    Text(
                      'Calculate Calories Burned',
                      style: cardTextStyle,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bigCardButton(VoidCallback onPressed, Widget child) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Container(
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [child],
          ),
        ),
      ),
    );
  }

  // Method to display selected workout description in a scrollable card
  List<Widget> printSelectedWorkoutDescription(selectedWorkouts, context) {
    return [
      if (selectedWorkouts.isNotEmpty)
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Card(
            color: primary,
            child: Center(
              child: SizedBox(
                height: 150,
                width: 700,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: SingleChildScrollView(
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: primary,
                        child: Text(
                          // Display the name and description of the last selected workout
                          "${selectedWorkouts.last.name}:\n${selectedWorkouts.last.description}",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFe9e6df)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            child: Text(
              "Do selected Workouts (${selectedWorkouts.length})",
              style: const TextStyle(
                  color: Color(0xFFe9e6df), fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Event workout;
              // If there are selected workouts
              if (selectedWorkouts.isNotEmpty) {
                // Show date picker to select workout date
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(2024, 1, 1),
                    lastDate: DateTime.utc(2048, 12, 31));
                for (int i = 0; i < selectedWorkouts.length; i++) {
                  // If a valid date is selected
                  if (pickedDate != null) {
                    if (await DatabaseHelper.instance
                        .doesNullEventExist('', '')) {
                      // Create an Event for each selected workout
                      workout = Event(
                          workoutName: selectedWorkouts[i].name,
                          workoutMuscle: selectedWorkouts[i].muscle,
                          met: selectedWorkouts[i].met,
                          day: pickedDate.day,
                          month: pickedDate.month,
                          year: pickedDate.year,
                          totalCalories: await DatabaseHelper.instance
                              .getCaloriesForDay(pickedDate.day,
                                  pickedDate.month, pickedDate.year),
                          caloriesBurned: await DatabaseHelper.instance
                              .getCaloriesBurnedForWorkout(
                                  selectedWorkouts[i].name,
                                  selectedWorkouts[i].muscle,
                                  pickedDate.day,
                                  pickedDate.month,
                                  pickedDate.year));
                    } else {
                      workout = Event(
                          workoutName: selectedWorkouts[i].name,
                          workoutMuscle: selectedWorkouts[i].muscle,
                          met: selectedWorkouts[i].met,
                          day: pickedDate.day,
                          month: pickedDate.month,
                          year: pickedDate.year,
                          totalCalories: 0,
                          caloriesBurned: 0);
                    }
                    if (!(await DatabaseHelper.instance.doesEventExist(
                        selectedWorkouts[i].name,
                        selectedWorkouts[i].muscle,
                        pickedDate.day,
                        pickedDate.month,
                        pickedDate.year))) {
                      // Insert the workout event into the database
                      DatabaseHelper.instance.insertEvent(workout);
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                              "Added ${selectedWorkouts[i].name} for ${pickedDate.month}/${pickedDate.day}/${pickedDate.year}"),
                        ),
                      );
                    } else {
                      messenger.showSnackBar(const SnackBar(
                        content: Text("Event Already Exists"),
                      ));
                    }
                  }
                }
              }
            },
          ),
        ),
      )
    ];
  }
}
