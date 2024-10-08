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
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.purple, Colors.blue], // ไล่เฉดสีม่วง-น้ำเงิน
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            'My Habits',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors
                  .white, // ต้องการให้สีตัวอักษรเป็นสีขาวในกรณีที่ใช้ Shader
            ),
          ),
        ),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 8), // กำหนดระยะห่างระหว่างรายการ
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.lightBlueAccent
                          ], // ไล่สีขาว-ฟ้าอ่อน
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10), // มุมโค้งมน
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/habits/${habit.id}');
                        },
                        minVerticalPadding: 16,
                        leading: Icon(habit.icon),
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
                              icon: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.purple,
                                      Colors.blue
                                    ], // ไล่สีม่วง-น้ำเงินสำหรับปุ่มแก้ไข
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                padding: const EdgeInsets.all(
                                    8.0), // พื้นที่ภายในปุ่ม
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white, // สีของไอคอนแก้ไข
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteHabit(habit.id!);
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red, // สีของปุ่มลบ
                                ),
                                padding: const EdgeInsets.all(
                                    8.0), // พื้นที่ภายในปุ่ม
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white, // สีของไอคอนลบ
                                ),
                              ),
                            ),
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
