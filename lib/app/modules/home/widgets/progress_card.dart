import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

class ProgressCard extends StatelessWidget {
  HabitsController habitsCtrl = Get.put(HabitsController());
  int completedHabitsCount = 0;
  int allHabitsCount = 0;
  double progressValue = 0.0;

  ProgressCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (habitsCtrl.habitRecordsList.isNotEmpty) {
        completedHabitsCount = habitsCtrl.habitRecordsList
            .where((habitRecord) => habitRecord.status == true)
            .length;
        allHabitsCount = habitsCtrl.habitRecordsList.length;

        progressValue = completedHabitsCount / allHabitsCount;
      }
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // ปรับขอบให้โค้ง
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6E33FF), // ไล่สีเหมือนในตัวอย่างที่ให้มา
                  Color(0xFFB44AC3),
                  Color(0xFFCE62CF)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.5),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 120, // Adjust to increase size
                      height: 120, // Adjust to increase size
                      child: FittedBox(
                        // Use FittedBox to scale the CircularProgressIndicator
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                              strokeWidth: 5, // Adjust thickness as needed
                            ),
                            Center(
                              child: Text(
                                '${(progressValue * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$completedHabitsCount of $allHabitsCount habits',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        const Text(
                          'Completed today!',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
