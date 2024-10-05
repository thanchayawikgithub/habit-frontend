import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';
import 'package:habit_frontend/app/modules/report/views/report_view.dart';
import 'package:habit_frontend/app/modules/report/views/widget/calender_widget.dart';

class BuildInfo extends GetView<HabitsController> {
  const BuildInfo({super.key, required this.report, required this.index});
  final ReportView report;
  final int index;
  @override
  Widget build(BuildContext context) {
    Habit habit = controller.habitsList[index];
    return Column(
      children: [
        const CalenderWidget(),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${habit.title} ${habit.period} Day',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Hbbit Name : ",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              habit.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              habit.description,
              style: const TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
