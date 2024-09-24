import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/habit/views/habit_view.dart';

class GoalsDetail extends StatelessWidget {
  final HabitView habit;
  final int index;
  const GoalsDetail({super.key, required this.habit, required this.index});

  @override
  Widget build(BuildContext context) {
    final habits = habit.habitData[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals : ${habits.title}',
            style: const TextStyle(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress: ${habits.progress}%'),
            Text('Target: ${habits.target}'),
            Text('Status: ${habits.status}'),
          ],
        ),
      ),
    );
  }
}
