import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';

import 'package:habit_frontend/app/modules/habits/controllers/habits_detail_controller.dart';

class HabitDetailView extends GetView<HabitDetailController> {
  const HabitDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          Habit habit = controller.habit.value;
          return Text(habit.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ));
        }),
      ),
    );
  }
}
