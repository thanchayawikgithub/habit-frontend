import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/modules/habits/views/edit_habit.dart';
import 'package:habit_frontend/app/modules/home/controllers/home_controller.dart';

class MyGoalsDetail extends GetView<HomeController> {
  const MyGoalsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(); // กลับไปยังหน้าก่อนหน้า
            },
          ),
        ),
        body: Obx(() {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Goals',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.habitsList.length,
                    itemBuilder: (context, index) {
                      Habit habit = controller.habitsList[index];
                      return Container(
                          margin: const EdgeInsets.only(
                              bottom: 8), // Space between items
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.habitsList[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    PopupMenuButton<int>(
                                      icon: const Icon(
                                          Icons.more_vert), // ไอคอนสามจุด
                                      onSelected: (value) {
                                        // ทำงานเมื่อเลือกเมนู
                                        if (value == 1) {
                                          // ทำบางอย่าง
                                          Get.to(() => EditHabit(
                                                habit: habit,
                                              ));
                                        } else if (value == 2) {
                                          // ทำบางอย่าง
                                          controller.deleteHabit(habit.id!);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 1,
                                          child: Text("Edit"),
                                        ),
                                        const PopupMenuItem(
                                          value: 2,
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: 0.5,
                                  backgroundColor: Colors.grey[300],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.deepPurple),
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(4),
                                  // Adjust thickness as needed
                                ),
                                const SizedBox(height: 8),
                                const Text("5 fron 7 day target"),
                                Text(
                                  "Everyday",
                                  style:
                                      TextStyle(color: Colors.deepOrange[500]),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
