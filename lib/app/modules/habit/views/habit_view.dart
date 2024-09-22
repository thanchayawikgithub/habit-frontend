import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';
import 'package:habit_frontend/app/modules/habit/views/Habit_Item.dart';
import 'package:habit_frontend/app/modules/habit/views/goals_view.dart';

import '../controllers/habit_controller.dart';

class HabitView extends GetView<HabitController> {
  HabitView({super.key});

  final List<HabitItem> habitData = [
    HabitItem(
      id: 1,
      title: 'Journaling everyday',
      progress: 100,
      target: '7 from 7 days target',
      status: 'Achieved',
    ),
    HabitItem(
      id: 2,
      title: 'Cooking Practice',
      progress: 100,
      target: '7 from 7 days target',
      status: 'Achieved',
    ),
    HabitItem(
      id: 3,
      title: 'Vitamin',
      progress: 70,
      target: '5 from 7 days target',
      status: 'Unachieved',
    ),
    HabitItem(
      id: 4,
      title: 'Exercise',
      progress: 90,
      target: '6 from 7 days target',
      status: 'Unachieved',
    ),
    HabitItem(
      id: 5,
      title: 'Meditation',
      progress: 60,
      target: '4 from 7 days target',
      status: 'Achieved',
    ),
    HabitItem(
      id: 6,
      title: 'Reading Books',
      progress: 80,
      target: '5 from 7 days target',
      status: 'Achieved',
    ),
  ];

  void indexHabit() {
    final habit = habitData.indexed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBarWidget(),
        appBar: AppBar(
          title: Text(
            'Progress',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress Report',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: 'This Month',
                    elevation: 40,
                    onChanged: (String? newValue) {},
                    items: <String>['This Month', 'Last Month']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(height: 20),
              // Progress Circle and Goals Summary
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Goals list
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Goals',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // ใส่ฟังก์ชันที่ต้องการทำงานเมื่อกดปุ่ม
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GoalsView(
                                                habit: HabitView(),
                                              )),
                                    );
                                  },
                                  child: Text(
                                    'See All',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                              ],
                            ),
                            // Progress circle
                            Center(
                                child: Column(children: [
                              SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Stack(fit: StackFit.expand, children: [
                                    CircularProgressIndicator(
                                      value: 0.6,
                                      strokeWidth: 10,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.purple),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        '60%',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ])),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '✔ 11 Habits goal has achieved\n',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    TextSpan(
                                      text: '✘ 6 Habits goal hasn\'t achieved',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                            SizedBox(height: 20),
                            // ListView of Habit Items
                            Container(
                              height: 300,
                              child: ListView.builder(
                                itemCount: habitData.length,
                                itemBuilder: (context, index) {
                                  final habit = habitData[index];
                                  return HabitItem(
                                    title: habit.title,
                                    progress: habit.progress,
                                    target: habit.target,
                                    status: habit.status,
                                    id: habit.id,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  // ใส่ฟังก์ชันที่ต้องการทำงานเมื่อกดปุ่ม
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GoalsView(
                                              habit: HabitView(),
                                            )),
                                  );
                                },
                                child: Text(
                                  'See All',
                                  style: TextStyle(color: Colors.purple),
                                ),
                              ),
                            ),
                          ])))
            ],
          ),
        ));
  }
}
