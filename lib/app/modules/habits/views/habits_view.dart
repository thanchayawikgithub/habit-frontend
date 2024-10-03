import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/habits/views/edit_habit.dart';

import '../controllers/habits_controller.dart';

class HabitsView extends GetView<HabitsController> {
  HabitsView({super.key});

  List<Habit> habits = [
    Habit(
        title: "Drink Water",
        description: "Drink Water 8 cups",
        period: 3,
        dayOfweeks: ['mon']),
    Habit(
        title: "Exercise",
        description: "30 minutes of workout",
        period: 3,
        dayOfweeks: ['mon']),
    Habit(
        title: "Read",
        description: "Read for 20 minutes",
        period: 3,
        dayOfweeks: ['mon']),
    Habit(
        title: "Read",
        description: "Read for 20 minutes",
        period: 3,
        dayOfweeks: ['mon']),
    Habit(
        title: "Read",
        description: "Read for 20 minutes",
        period: 3,
        dayOfweeks: ['mon']),
    Habit(
        title: "Read",
        description: "Read for 20 minutes",
        period: 3,
        dayOfweeks: ['mon']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBarWidget(),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Habits',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
                      child: ListTile(
                        minVerticalPadding: 16,
                        title: Text(
                          habit.title,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
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
                              icon: Icon(Icons.delete))
                        ]),
                      ),
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
          Get.to(() => EditHabit());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
