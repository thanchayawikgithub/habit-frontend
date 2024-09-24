import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/habit/views/widget/habit_list.dart';

class HabitItem extends StatelessWidget {
  final int id;
  final String title;
  final int progress;
  final String target;
  final String status;

  const HabitItem({
    super.key,
    required this.id,
    required this.title,
    required this.progress,
    required this.target,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return HabitList(
      habitItem: HabitItem(
          id: id,
          title: title,
          progress: progress,
          target: target,
          status: status),
    );
  }
}
