import 'package:flutter/material.dart';
import 'package:habit_frontend/app/data/models/habit.dart';

class TodayHabit extends StatelessWidget {
  const TodayHabit({super.key});

  @override
  Widget build(BuildContext context) {
    List<Habit> todayHabits = [
      Habit(title: "Drink Water", description: "Drink Water 8 cups"),
      Habit(title: "Exercise", description: "30 minutes of workout"),
      Habit(title: "Read", description: "Read for 20 minutes"),
    ];

    return Card(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today Habit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepOrange[500]),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todayHabits.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 8), // Space between items
                    decoration: BoxDecoration(
                      color: Colors.grey[100], // Grey background
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    child: ListTile(
                      minVerticalPadding: 16,
                      title: Text(
                        todayHabits[index].title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Checkbox(
                        value: false, // Set this based on your state
                        onChanged: (bool? value) {
                          // Handle checkbox change
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
