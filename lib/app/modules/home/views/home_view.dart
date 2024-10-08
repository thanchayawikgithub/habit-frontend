import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

import 'package:habit_frontend/app/modules/habits/views/edit_habit.dart';
import 'package:habit_frontend/app/modules/home/widgets/progress_card.dart';
import 'package:habit_frontend/app/modules/home/widgets/today_habit.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HabitsController habitsCtrl = Get.put(HabitsController());
  HomeView({super.key}) {
    habitsCtrl.fetchTodayHabits();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 30),
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
                    _auth.currentUser?.displayName ?? '',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange[500]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProgressCard(),
              const SizedBox(height: 10),
              TodayHabit(),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 55, // ปรับขนาดปุ่มให้เล็กลง
        width: 55, // ปรับขนาดปุ่มให้เล็กลง
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
            Get.to(() => EditHabit());
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
