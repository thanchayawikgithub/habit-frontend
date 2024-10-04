import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';
import 'package:habit_frontend/app/modules/report/views/report_view.dart';
import 'package:habit_frontend/app/modules/habits/widget/build_info.dart';
import 'package:habit_frontend/app/modules/report/views/widget/calender_widget.dart';

class GoalsDetail extends GetView<HabitsController> {
  final ReportView report;
  final int index;
  GoalsDetail({super.key, required this.report, required this.index});

  @override
  Widget build(BuildContext context) {
    Habit habit = controller.habitsList[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit : ${habit.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: BuildInfo(
                index: index,
                report: report,
              ))),
    );
  }
}
