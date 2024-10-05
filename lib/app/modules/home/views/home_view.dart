import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';

import 'package:habit_frontend/app/modules/habits/views/edit_habit.dart';
import 'package:habit_frontend/app/modules/home/widgets/progress_card.dart';
import 'package:habit_frontend/app/modules/home/widgets/today_habit.dart';
import 'package:habit_frontend/app/modules/home/widgets/my_goal.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _auth.currentUser?.displayName ?? 'User',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EditHabit());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
