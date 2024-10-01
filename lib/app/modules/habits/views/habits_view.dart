import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';

import '../controllers/habits_controller.dart';

class HabitsView extends GetView<HabitsController> {
  HabitsView({super.key});

  List<Habit> habits = [
    Habit(title: "Drink Water", description: "Drink Water 8 cups"),
    Habit(title: "Exercise", description: "30 minutes of workout"),
    Habit(title: "Read", description: "Read for 20 minutes"),
    Habit(title: "Read", description: "Read for 20 minutes"),
    Habit(title: "Read", description: "Read for 20 minutes"),
    Habit(title: "Read", description: "Read for 20 minutes"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Habits',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              // Container(
              //   child: CarouselSlider(
              //       items: habits
              //           .map(
              //             (e) => Container(
              //               width: 40,
              //               margin: EdgeInsets.symmetric(horizontal: 5),
              //               decoration: BoxDecoration(
              //                   color: Colors.deepPurple[200],
              //                   borderRadius: BorderRadius.circular(8)),
              //               child: Column(
              //                 children: [Text('1'), Text('March')],
              //               ),
              //             ),
              //           )
              //           .toList(),
              //       options: CarouselOptions(height: 100)),
              // )
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
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
                          habits[index].title,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Checkbox(
                          value: false, // Set this based on your state
                          onChanged: (bool? value) {
                            // Handle checkbox change
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
