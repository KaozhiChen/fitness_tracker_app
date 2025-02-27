import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/workout_tracker_screen.dart';
import 'package:fitness_tracker_app/theme/colors.dart';

class CoreModel extends WorkoutModel {
  String muscle = 'Core';
  CoreModel(super.name, super.met, super.isSelected, super.description);
}

class CoreWorkouts extends StatefulWidget {
  const CoreWorkouts({super.key});

  @override
  State<CoreWorkouts> createState() => _CoreWorkoutsState();
}

class _CoreWorkoutsState extends State<CoreWorkouts> {
  List<CoreModel> workoutsCore = [
    CoreModel("Plank (moderate)", 3.8, false, """
Duration: 30-60 seconds for 2-3 sets

1. Start in a high plank position with your hands slightly wider than shoulder-width apart and your feet together.
2. Keep your body straight and engage your core, ensuring that your hips are in line with your shoulders.
3. Hold this position for 30-60 seconds, aiming for 2-3 sets."""),
    CoreModel("Crunches (moderate)", 3.8, false, """
Duration: 10-15 reps for 2-3 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head, and lift your shoulders off the ground towards your knees.
3. Keep your neck and spine in a neutral position, and exhale as you lift your shoulders off the ground.
4. Pause for a moment, and then lower your shoulders back to the ground.
5. Aim for 10-15 reps, completing 2-3 sets."""),
    CoreModel("Leg Raises (moderate)", 3.8, false, """
Duration: 10-15 reps for 2-3 sets

1. Lie on your back with your legs straight out in front of you.
2. Place your hands by your sides or under your hips for extra support.
3. Lift your legs off the ground until they are perpendicular to the floor.
4. Lower your legs back down towards the ground without touching it.
5. Aim for 10-15 reps, completing 2-3 sets.
"""),
    CoreModel("Sit Ups (moderate)", 3.8, false, """
Duration: 10-15 reps for 2-3 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head or crossed on your chest.
3. Engage your core and lift your upper body off the ground towards your knees.
4. Pause for a moment, and then lower your upper body back to the ground.
5. Aim for 10-15 reps, completing 2-3 sets."""),
    CoreModel("Plank (vigorous)", 8, false, """
Duration: 60-90 seconds for 3-4 sets

1. Start in a high plank position with your hands slightly wider than shoulder-width apart and your feet together.
2. Keep your body straight and engage your core, ensuring that your hips are in line with your shoulders.
3. Hold this position for 60-90 seconds, aiming for 3-4 sets."""),
    CoreModel("Crunches (vigorous)", 8, false, """
Duration: 15-20 reps for 3-4 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head, and lift your shoulders off the ground towards your knees.
3. Keep your neck and spine in a neutral position, and exhale as you lift your shoulders off the ground.
4. Pause for a moment, and then lower your shoulders back to the ground.
5. Aim for 15-20 reps, completing 3-4 sets."""),
    CoreModel("Leg Raises (vigorous)", 8, false, """
Duration: 15-20 reps for 3-4 sets

1. Lie on your back with your legs straight out in front of you.
2. Place your hands by your sides or under your hips for extra support.
3. Lift your legs off the ground until they are perpendicular to the floor.
4. Lower your legs back down towards the ground without touching it.
5. Aim for 15-20 reps, completing 3-4 sets."""),
    CoreModel("Sit Ups (vigorous)", 8, false, """
Duration: 15-20 reps for 3-4 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head or crossed on your chest.
3. Engage your core and lift your upper body off the ground towards your knees.
4. Pause for a moment, and then lower your upper body back to the ground.
5. Aim for 15-20 reps, completing 3-4 sets."""),
  ];

  List<CoreModel> selectedWorkouts = [];
  final WorkoutScreen _workoutPage = const WorkoutScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CORE WORKOUTS',
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Color(0xFFFFFFFF),
              letterSpacing: 3.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: fourthColor,
      ),
      backgroundColor: const Color(0xFFe9e6df),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: SizedBox(
                height: selectedWorkouts.isEmpty ? 500 : 332,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: fourthColor,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      itemCount: workoutsCore.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CoreWorkoutItem(
                          workoutsCore[index].name,
                          workoutsCore[index].muscle,
                          workoutsCore[index].met,
                          workoutsCore[index].isSelected,
                          workoutsCore[index].description,
                          index,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            for (int i = 0;
                i <
                    _workoutPage
                        .printSelectedWorkoutDescription(
                            selectedWorkouts, context)
                        .length;
                i++)
              _workoutPage.printSelectedWorkoutDescription(
                  selectedWorkouts, context)[i],
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'Back To Home',
                  backgroundColor: fourthColor,
                  child: const Icon(Icons.close),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CoreWorkoutItem(String name, String muscle, double met,
      bool isSelected, String description, int index) {
    return Card(
      color: fourthColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFe9e6df),
            ),
          ),
          subtitle: Text(
            muscle,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(132, 233, 230, 223)),
          ),
          trailing: isSelected
              ? const Icon(
                  Icons.check_circle,
                  color: Color(0xFFe9e6df),
                )
              : const Icon(Icons.check_circle,
                  color: Color.fromARGB(132, 233, 230, 223)),
          onTap: () {
            setState(() {
              workoutsCore[index].isSelected = !workoutsCore[index].isSelected;
              if (workoutsCore[index].isSelected) {
                selectedWorkouts
                    .add(CoreModel(name, met, isSelected, description));
              } else if (!(workoutsCore[index].isSelected)) {
                selectedWorkouts.removeWhere(
                    (element) => element.name == workoutsCore[index].name);
              }
            });
          },
        ),
      ),
    );
  }
}
