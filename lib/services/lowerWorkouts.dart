import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/workout_tracker_screen.dart';
import 'package:fitness_tracker_app/theme/colors.dart';


class LowerModel extends WorkoutModel {
  String muscle = 'Lower Body';
  LowerModel(super.name, super.met, super.isSelected, super.description);
}

class LowerWorkouts extends StatefulWidget {
  const LowerWorkouts({super.key}); // Constructor for LowerWorkouts widget

  @override
  State<LowerWorkouts> createState() => _LowerWorkoutsState(); // Creating the state for LowerWorkouts
}

class _LowerWorkoutsState extends State<LowerWorkouts> {
  List<LowerModel> workoutsLower = [
    LowerModel("Buttkicks (moderate)", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Keeping your upper body straight, lift your left foot off the ground and bring your heel towards your buttocks.
3. Lower your left foot back to the ground and repeat the movement with your right foot.
4. Alternate between left and right foot, continuously bringing your heels towards your buttocks.
5. Aim for a moderate pace, kicking your heels up as close to your buttocks as possible.
6. Complete 8-12 reps on each side for 2-3 sets."""),
    LowerModel("High Knees (moderate)", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Engage your core and bring your left knee towards your chest.
3. Quickly lower your left leg back to the ground and immediately bring your right knee towards your chest.
4. Continue alternating between left and right knees, bringing them towards your chest in a running motion.
5. Aim for a moderate pace, bringing your knees up as high as possible while maintaining good posture.
6. Complete 8-12 reps on each side for 2-3 sets."""),
    LowerModel("Squats (moderate)", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet slightly wider than hip-width apart, with your toes pointing slightly outwards.
2. Keep your chest up, engage your core, and lower your body by bending your knees.
3. Keep your weight in your heels and push your hips back as if you are sitting on a chair.
4. Lower your body until your thighs are parallel to the ground or as low as comfortable for you.
5. Push through your heels and squeeze your glutes to raise your body back up to the starting position.
6. Aim for a moderate pace, keeping your chest up and your knees pointing in the same direction as your toes.
7. Complete 8-12 reps for 2-3 sets."""),
    LowerModel("Lunges (moderate)", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet hip-width apart, with your arms at your sides.
2. Take a big step forward with your left foot, and lower your body by bending both knees.
3. Keep your front knee directly above your ankle, and lower your back knee towards the ground without touching it.
4. Push through your front heel to raise your body back up to the starting position.
5. Repeat with your right foot stepping forward, alternating between left and right.
6. Aim for a moderate pace, keeping your upper body straight and your core engaged.
7. Complete 8-12 reps on each side for 2-3 sets."""),
    LowerModel("Buttkicks (vigorous)", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Keeping your upper body straight, lift your left foot off the ground and bring your heel towards your buttocks.
3. Lower your left foot back to the ground and repeat the movement with your right foot.
4. Alternate between left and right foot, continuously bringing your heels towards your buttocks.
5. Aim for a fast pace, kicking your heels up as close to your buttocks as possible.
6. Complete 12-15 reps on each side for 3-4 sets."""),
    LowerModel("High Knees (vigorous)", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Engage your core and bring your left knee towards your chest.
3. Quickly lower your left leg back to the ground and immediately bring your right knee towards your chest.
4. Continue alternating between left and right knees, bringing them towards your chest in a running motion.
5. Aim for a fast pace, bringing your knees up as high as possible while maintaining good posture.
6. Complete 12-15 reps on each side for 3-4 sets."""),
    LowerModel("Squats (vigorous)", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet slightly wider than hip-width apart, with your toes pointing slightly outwards.
2. Keep your chest up, engage your core, and lower your body by bending your knees.
3. Keep your weight in your heels and push your hips back as if you are sitting on a chair.
4. Lower your body until your thighs are parallel to the ground or as low as comfortable for you.
5. Push through your heels and squeeze your glutes to raise your body back up to the starting position.
6. Aim for a fast pace, keeping your chest up and your knees pointing in the same direction as your toes.
7. Complete 12-15 reps for 3-4 sets."""),
    LowerModel("Lunges (vigorous)", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet hip-width apart, with your arms at your sides.
2. Take a big step forward with your left foot, and lower your body by bending both knees.
3. Keep your front knee directly above your ankle, and lower your back knee towards the ground without touching it.
4. Push through your front heel to raise your body back up to the starting position.
5. Repeat with your right foot stepping forward, alternating between left and right.
6. Aim for a fast pace, keeping your upper body straight and your core engaged.
7. Complete 12-15 reps on each side for 3-4 sets."""),
  ];

  // A list to hold selected workouts
  List<LowerModel> selectedWorkouts = [];
  final WorkoutScreen _workoutPage = const WorkoutScreen(); // WorkoutScreen instance used to print selected workout descriptions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'LOWER WORKOUTS',
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
        backgroundColor: thirdColor,
      ),
      backgroundColor: const Color(0xFFe9e6df),
      body: SingleChildScrollView(child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0,25,0,0),
              child: SizedBox(
                height: selectedWorkouts.isEmpty ? 500 : 332,
            child: ScrollConfiguration(
              behavior:
                  const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color:
                    secondary,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  itemCount: workoutsLower.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LowerWorkoutItem(
                      workoutsLower[index].name,
                      workoutsLower[index].muscle,
                      workoutsLower[index].met,
                      workoutsLower[index].isSelected,
                      workoutsLower[index].description,
                      index,
                    );
                  },
                ),
              ),
            ),
          ),
          ),
          // Displays descriptions of selected workouts
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
                backgroundColor: thirdColor,
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  // Enables the items to be created and clickable
  Widget LowerWorkoutItem(String name, String muscle, double met,
      bool isSelected, String description, int index) {
    return Card(
      color: thirdColor,
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
              workoutsLower[index].isSelected =
                  !workoutsLower[index].isSelected;
              if (workoutsLower[index].isSelected) {
                selectedWorkouts
                    .add(LowerModel(name, met, isSelected, description));
              } else if (!(workoutsLower[index].isSelected)) {
                selectedWorkouts.removeWhere(
                    (element) => element.name == workoutsLower[index].name);
              }
            });
          },
        ),
      ),
    );
  }
}