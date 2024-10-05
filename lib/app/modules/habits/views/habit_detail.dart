import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';

import 'package:habit_frontend/app/modules/habits/controllers/habits_detail_controller.dart';

class HabitDetailView extends GetView<HabitDetailController> {
  const HabitDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Habit habit = controller.habit.value;
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
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Description: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      habit.description,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Period: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      habit.period.toString(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ));
    });
  }
}
