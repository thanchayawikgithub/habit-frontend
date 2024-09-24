import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/habit/views/Habit_Item.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key, required this.habitItem});
  final HabitItem habitItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Progress indicator
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: habitItem.progress / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Center(
                  child: Text(
                    '${habitItem.progress}%',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Goal details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habitItem.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  habitItem.target,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Status
          Container(
            decoration: BoxDecoration(
              color: habitItem.status == 'Achieved'
                  ? Colors.green[100]
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              habitItem.status,
              style: TextStyle(
                color:
                    habitItem.status == 'Achieved' ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
