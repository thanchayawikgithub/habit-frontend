import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/habits/views/edit_habit.dart';

import '../controllers/habits_controller.dart';

class HabitsView extends GetView<HabitsController> {
  const HabitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(EditHabit());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
