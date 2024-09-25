import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/home/widgets/add_habit.dart';
import 'package:habit_frontend/app/modules/home/widgets/progress_card.dart';
import 'package:habit_frontend/app/modules/home/widgets/today_habit.dart';
import 'package:habit_frontend/app/modules/home/widgets/my_goal.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomAppBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Hello,',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Than',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[500]),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const ProgressCard(),
                const SizedBox(height: 10),
                const TodayHabit(),
                const SizedBox(height: 10),
                const MyGoals()
              ],
            ),
          ),
        ),
        floatingActionButton: AddHabit());
  }
}
