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
        title: const Text(
          'My Habits',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    return ListTile(
                      onTap: () {
                        Get.toNamed('/habits/${habit.id}');
                      },
                      minVerticalPadding: 16,
                      leading: Icon(habit.icon),
                      title: Text(
                        habit.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                            onPressed: () {
                              Get.to(() => EditHabit(
                                    habit: habit,
                                  ));
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              controller.deleteHabit(habit.id!);
                            },
                            icon: const Icon(Icons.delete))
                      ]),
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
