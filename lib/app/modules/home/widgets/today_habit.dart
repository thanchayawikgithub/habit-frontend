import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit_record.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

import 'package:habit_frontend/app/modules/home/controllers/home_controller.dart';

class TodayHabit extends GetView<HomeController> {
  HabitsController habitsCtrl = Get.put(HabitsController());

  TodayHabit({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Card(
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 520,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today Habit',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                Expanded(
                  child: habitsCtrl.habitRecordsList.isNotEmpty
                      ? ListView.builder(
                          itemCount: habitsCtrl.habitRecordsList.length,
                          itemBuilder: (context, index) {
                            HabitRecord habitRecord =
                                habitsCtrl.habitRecordsList[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                  bottom: 8), // Space between items
                              decoration: BoxDecoration(
                                color: habitRecord.habit!.color.withOpacity(50 /
                                    255), // Background color of the ListTile
                                borderRadius: BorderRadius.circular(
                                    16), // Rounds the corners
                              ),
                              child: ListTile(
                                tileColor: Colors.transparent,
                                minVerticalPadding: 16,
                                leading: Icon(
                                  habitRecord.habit?.icon,
                                  color: habitRecord.habit!.color,
                                ),
                                title: Text(
                                  habitRecord.habit?.title ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors
                                          .black // สีข้อความเป็นสีดำเพื่อความชัดเจน
                                      ),
                                ),
                                trailing: Checkbox(
                                  value: habitRecord
                                      .status, // Set this based on your state
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      habitsCtrl
                                          .changeHabitRecordStatus(habitRecord);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'Empty',
                            style: TextStyle(fontSize: 20),
                          ),
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
