import 'package:flutter/material.dart';
import 'package:habit_frontend/app/data/models/habit.dart';

class YourGoals extends StatelessWidget {
  const YourGoals({Key? key}) : super(key: key);

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
        height: 450,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Goals',
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
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todayHabits.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 8), // Space between items
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Grey background
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  todayHabits[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Icon(Icons.more_vert)
                              ],
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.deepPurple),
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(4),
                              // Adjust thickness as needed
                            ),
                            SizedBox(height: 8),
                            Text("5 fron 7 day target"),
                            Text(
                              "Everyday",
                              style: TextStyle(color: Colors.deepOrange[500]),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
