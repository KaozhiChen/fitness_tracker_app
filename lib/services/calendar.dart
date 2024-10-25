import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/database_helper.dart';
import 'package:intl/intl.dart';
import 'event.dart';
import 'package:fitness_tracker_app/theme/colors.dart';


class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    required this.today, // Required today date passed as an argument
  });

  final DateTime today; // Today's date

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime? _selectedDay; // Stores the currently selected day
  // Method that handles selecting and deselecting a day on the calendar
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      // If no day is selected, select the new day
      if (_selectedDay == null) {
        _selectedDay = selectedDay;
      // If the same day is clicked, deselect it
      } else if (_selectedDay == selectedDay) {
        _selectedDay = null;
      // If a different day is selected, update the selected day
      } else if (_selectedDay != null) {
        _selectedDay = selectedDay;
      }
    });
  }

  var selectedWorkout = []; // List to store workouts for the selected day

  @override
  Widget build(BuildContext context) {
    int day, month, year;
    // If a day is selected, get its day, month, and year; otherwise default to Jan 1, 2024
    if (_selectedDay != null) {
      day = _selectedDay!.day;
      month = _selectedDay!.month;
      year = _selectedDay!.year;
    } else {
      day = 1;
      month = 1;
      year = 2024;
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 20,
      children: [
        FutureBuilder<List<Map<String, dynamic>>>(
            // Query database for events/workouts for the selected day
            future: DatabaseHelper.instance.queryEventsforDay(day, month, year),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final selectedWorkouts = snapshot.data!;

                // Add selected workouts to the list
                for (int i = 0; i < selectedWorkouts.length; i++) {
                  selectedWorkout.add(selectedWorkouts[i]);
                }

                return Material(
                  color: primary,
                  elevation: 10,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: TableCalendar(
                      daysOfWeekHeight: 30,
                      rowHeight: 34,
                      locale: "en_US", // Locale for English date format
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        headerPadding: const EdgeInsets.all(1),
                        titleTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 46, 51, 42),
                          fontFamily: ".SF UI Display",
                          fontSize: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFe9e6df),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      sixWeekMonthsEnforced: true, // Ensure 6-week view in months
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2010, 1, 1),
                      lastDay: DateTime.utc(2048, 12, 31),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color.fromARGB(183, 233, 230, 223),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFe9e6df),
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: TextStyle(
                          color: Color(0xFFe9e6df),
                        ),
                        outsideTextStyle: TextStyle(
                          color: Color.fromARGB(113, 233, 230, 223),
                        ),
                        weekendTextStyle: TextStyle(
                          color: Color(0xFFe9e6df),
                        ),
                        todayTextStyle: TextStyle(
                          color: Color(0xFF99a98c),
                        ),
                        selectedTextStyle: TextStyle(
                          color: Color(0xFF99a98c),
                        ),
                      ),
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
        // Display list of workouts or relevant messages based on selected day
        (_selectedDay != null)
            ? FutureBuilder<List<Map<String, dynamic>>>(
                future:
                    DatabaseHelper.instance.queryEventsforDay(day, month, year),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final selectedWorkouts = snapshot.data!;
                    List<Event> workoutsForDay = [];
                    // Populate workoutsForDay list with events from the database
                    for (int i = 0; i < selectedWorkouts.length; i++) {
                      var select = selectedWorkouts[i];
                      if (select['workoutName'].toString().isNotEmpty) {
                        Event workout = Event(
                            workoutName: select['workoutName'],
                            workoutMuscle: select['workoutMuscle'],
                            met: select['met'] ?? 0.0,
                            day: select['day'],
                            month: select['month'],
                            year: select['year'],
                            totalCalories: select['totalCalories'] ?? 0.0,
                            caloriesBurned: select['caloriesBurned'] ?? 0.0);
                        workoutsForDay.add(workout);
                      }
                    }
                    // Calculate total calories burned
                    double totalCaloriesBurned = 0.0;
                    for (int i = 0; i < selectedWorkouts.length; i++) {
                      var select = selectedWorkouts[i];
                      totalCaloriesBurned += (select['caloriesBurned'] ?? 0.0);
                    }
                    return Material(
                      elevation: 10,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                      child: SafeArea(
                        child: SizedBox(
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                // Display the formatted date for the selected day
                                DateFormat('yMMMMEEEEd').format(_selectedDay!),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 20, 0),
                                  child: ScrollConfiguration(
                                    behavior:
                                        const ScrollBehavior(),
                                    child: GlowingOverscrollIndicator(
                                      axisDirection: AxisDirection.down,
                                      color: primary,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          itemCount: workoutsForDay.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return SizedBox(
                                              height: 40,
                                              child: Card(
                                                color: secondary,
                                                child: Center(
                                                  child: Text(
                                                    '${workoutsForDay[index].workoutName}   (${workoutsForDay[index].workoutMuscle})',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      decoration: workoutsForDay[
                                                                      index]
                                                                  .caloriesBurned !=
                                                              0
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : null,
                                                      decorationThickness: 2,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (workoutsForDay.isEmpty)
                                if (_selectedDay!.day == DateTime.now().day &&
                                    _selectedDay!.month ==
                                        DateTime.now().month &&
                                    _selectedDay!.year == DateTime.now().year &&
                                    selectedWorkouts.isNotEmpty)
                                  Text(
                                    'Calorie Intake: ${selectedWorkouts[0]['totalCalories'] ?? 0.0} | Burned: $totalCaloriesBurned',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                else
                                  const Text(
                                    'Intake: 0 | Burned: 0',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                              else if (workoutsForDay.isNotEmpty)
                                Text(
                                  'Intake: ${workoutsForDay[0].totalCalories} | Burned: $totalCaloriesBurned',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              const SizedBox(height: 10),
                              if (workoutsForDay.isEmpty)
                                if (_selectedDay!.day == DateTime.now().day &&
                                    _selectedDay!.month ==
                                        DateTime.now().month &&
                                    _selectedDay!.year == DateTime.now().year &&
                                    selectedWorkouts.isNotEmpty)
                                  Text(
                                    'Total Calories for the Day: ${selectedWorkouts[0]['totalCalories'] ?? 0.0}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                else
                                  const Text(
                                    'No workouts found!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
            : Container(),
      ],
    );
  }
}
