import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/data/models/habit_record.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

import 'package:habit_frontend/app/modules/habits/controllers/habits_detail_controller.dart';

class HabitDetailView extends GetView<HabitDetailController> {
  HabitsController habitsCtrl = Get.put(HabitsController());
  String? habitId = Get.parameters['id'];
  HabitDetailView({super.key}) {
    if (habitId != null) {
      habitsCtrl.fetchHabit(habitId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Habit habit = habitsCtrl.habit.value;

      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(); // กลับไปยังหน้าก่อนหน้า
                },
              ),
              title: Text(habit.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ))),
          body: Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Description: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      habit.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      habit.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Icon: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Icon(habit.icon),
                  ],
                ),
                const Text(
                  'Records',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: habit.habitRecords.length,
                  itemBuilder: (context, index) {
                    HabitRecord habitRecord = habit.habitRecords[index];
                    return ListTile(
                      title: Text('Date : ${habitRecord.date}'),
                      trailing: Text(
                          'Status ${habitRecord.status == true ? 'Complete' : 'Pending'}'),
                    );
                  },
                ))
              ],
            ),
          ));
    });
  }
}
