import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

class AddHabit extends StatelessWidget {
  AddHabit({super.key});

  final HabitsController controller = Get.put(HabitsController());

  final List<DayInWeek> _days = [
    DayInWeek("Mon", dayKey: "mon"),
    DayInWeek("Thu", dayKey: "tue"),
    DayInWeek("Wed", dayKey: "wed"),
    DayInWeek("Thu", dayKey: "thu"),
    DayInWeek("Fri", dayKey: "fri"),
    DayInWeek("Sat", dayKey: "sat"),
    DayInWeek("Sun", dayKey: "sun"),
  ];

  @override
  Widget build(BuildContext context) {
    final customWidgetKey = GlobalKey<SelectWeekDaysState>();
    return FloatingActionButton(
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog.fullscreen(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Add Habit',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text("Title",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: controller.titleCtrl,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      TextField(
                        controller: controller.descriptionCtrl,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Text("Period",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Text("(day)",
                              style: TextStyle(
                                fontSize: 14,
                              ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: controller.periodCtrl,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SelectWeekDays(
                        key: customWidgetKey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        unselectedDaysBorderColor: Colors.deepPurple[500],
                        unSelectedDayTextColor: Colors.deepPurple[500],
                        selectedDayTextColor: Colors.white,
                        selectedDaysFillColor: Colors.deepPurple[500],
                        selectedDaysBorderColor: Colors.deepPurple[500],
                        days: _days,
                        border: true,
                        borderWidth: 1,
                        width: MediaQuery.of(context).size.width,
                        boxDecoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        onSelect: (values) {
                          controller.dayOfWeeksValue = values;
                        },
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width, // Set width
                        height: 50, // Set height
                        child: ElevatedButton(
                          onPressed: () {
                            controller.addHabit();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.deepPurple[500], // Background color
                            foregroundColor: Colors.white, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Border radius
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width, // Set width
                        height: 50, // Set height
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Button action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.grey[100], // Background color
                            foregroundColor: Colors.black, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Border radius
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        shape: const CircleBorder(),
        child: Icon(Icons.add));
  }
}
