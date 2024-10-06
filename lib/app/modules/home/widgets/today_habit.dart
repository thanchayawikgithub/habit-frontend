import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/data/models/habit_record.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';
import 'package:habit_frontend/app/modules/home/controllers/home_controller.dart';

class TodayHabit extends GetView<HomeController> {
  TodayHabit({super.key});
  HabitsController habitsCtrl = Get.put(HabitsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Card(
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today Habit',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed('/habits/');
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.deepOrange[500]),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: habitsCtrl.habitRecordsList.length,
                    itemBuilder: (context, index) {
                      HabitRecord habitRecord =
                          habitsCtrl.habitRecordsList[index];

                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 8), // Space between items
                        decoration: BoxDecoration(
                          color: Colors.grey[100], // Grey background
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                        child: ListTile(
                          minVerticalPadding: 16,
                          title: Text(
                            habitRecord.id!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Checkbox(
                            value: false, // Set this based on your state
                            onChanged: (bool? value) {
                              // Handle checkbox change
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
