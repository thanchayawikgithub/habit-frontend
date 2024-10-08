import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/habits/views/edit_habit.dart';

import '../controllers/habits_controller.dart';

class HabitsView extends GetView<HabitsController> {
  HabitsView({super.key}) {
    controller.fetchHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "My Habits",
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange[500]),
      )

          // ShaderMask(
          //   shaderCallback: (bounds) => const LinearGradient(
          //     colors: [Colors.purple, Colors.blue], // ไล่เฉดสีม่วง-น้ำเงิน
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ).createShader(bounds),
          //   child: const Text(
          //     'My Habits',
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //       color: Colors
          //           .white, // ต้องการให้สีตัวอักษรเป็นสีขาวในกรณีที่ใช้ Shader
          //     ),
          //   ),
          // ),
          ),
      bottomNavigationBar: const BottomAppBarWidget(),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.habitsList.length,
                  itemBuilder: (context, index) {
                    Habit habit = controller.habitsList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: habit.color.withOpacity(
                            50 / 255), // Background color of the ListTile
                        borderRadius:
                            BorderRadius.circular(16), // Rounds the corners
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/habits/${habit.id}');
                        },
                        tileColor: Colors.transparent,
                        minVerticalPadding: 16,
                        leading: Icon(
                          habit.icon,
                          color: habit.color,
                        ),
                        title: Text(
                          habit.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .black, // สีข้อความเป็นสีดำเพื่อความชัดเจน
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.to(() => EditHabit(
                                        habit: habit,
                                      ));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  controller.deleteHabit(habit.id!);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Container(
        height: 60, // ปรับขนาดปุ่มให้เล็กลง
        width: 60, // ปรับขนาดปุ่มให้เล็กลง
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF00E676), Color(0xFF00C853)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(EditHabit());
          },
          backgroundColor: Colors.transparent,
          elevation: 0, // เอาเงาออก
          highlightElevation: 0, // เอาเงาตอนชี้ออก
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
