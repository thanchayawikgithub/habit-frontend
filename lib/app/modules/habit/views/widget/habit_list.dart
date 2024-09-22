import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/habit/views/Habit_Item.dart';

class HabitList extends StatelessWidget {
  HabitList({Key? key, required this.habitItem}) : super(key: key);
  final HabitItem habitItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Progress indicator
          Container(
            width: 60,
            height: 60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: habitItem.progress / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Center(
                  child: Text(
                    '${habitItem.progress}%',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          // Goal details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habitItem.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  habitItem.target,
                  style: TextStyle(color: Colors.grey),
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
