import 'package:flutter/material.dart';

class HabitItem extends StatelessWidget {
  final int id;
  final String title;
  final int progress;
  final String target;
  final String status;

  HabitItem({
    required this.id,
    required this.title,
    required this.progress,
    required this.target,
    required this.status,
  });

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
                  value: progress / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Center(
                  child: Text(
                    '$progress%',
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
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  target,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Status
          Container(
            decoration: BoxDecoration(
              color:
                  status == 'Achieved' ? Colors.green[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              status,
              style: TextStyle(
                color: status == 'Achieved' ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
