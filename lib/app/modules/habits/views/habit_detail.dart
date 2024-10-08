import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/data/models/habit_record.dart';
import 'package:habit_frontend/app/modules/habits/controllers/habits_controller.dart';

import 'package:habit_frontend/app/modules/habits/controllers/habits_detail_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widget/calender.dart';

// ignore: must_be_immutable
class HabitDetailView extends GetView<HabitDetailController> {
  HabitsController habitsCtrl = Get.put(HabitsController());
  String? habitId = Get.parameters['id'];
  HabitDetailView({super.key}) {
    if (habitId != null) {
      habitsCtrl.fetchHabit(habitId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Habit habit = habitsCtrl.habit.value;
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back(); // กลับไปยังหน้าก่อนหน้า
              },
            ),
            title: Text(habit.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ))),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Description: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    habit.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Icon: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Icon(habit.icon),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: habit.habitRecords.length,
                itemBuilder: (context, index) {
                  HabitRecord habitRecord = habit.habitRecords[index];
                  DateTime focusedDay = habitRecord.date != null
                      ? DateTime.parse(habitRecord.date)
                      : DateTime.now();
                  DateTime selectedDay = DateTime.parse(habitRecord.date);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: (habitRecord.status == 'Complete' ||
                                      habitRecord.status == true)
                                  ? Colors.green[100]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Text(
                              ' ${habitRecord.status == 'Complete' || habitRecord.status == true ? 'Complete' : 'Pending'} ', // แสดงสถานะ
                              style: TextStyle(
                                  color: (habitRecord.status == 'Complete' ||
                                          habitRecord.status == true)
                                      ? Colors.green
                                      : Colors.grey,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            habitRecord.date,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TableCalendar(
                            focusedDay: focusedDay,
                            firstDay: DateTime(2010, 10, 16),
                            lastDay: DateTime(2030, 3, 14),
                            selectedDayPredicate: (day) {
                              return isSameDay(selectedDay,
                                  day); // กำหนดว่าเมื่อไหร่ที่จะแสดงว่าเป็นวัน selected
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              selectedDay = selectedDay;
                              focusedDay = focusedDay;
                            },
                            calendarBuilders: CalendarBuilders(
                                selectedBuilder: (context, date, _) {
                              // กำหนดสีของ selectedDay ขึ้นอยู่กับสถานะ
                              Color color = habitRecord.status
                                  ? Colors.green
                                  : Colors.red; // สีที่ใช้แสดง
                              return Container(
                                decoration: BoxDecoration(
                                  color: color, // กำหนดสีที่เลือก
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                        color:
                                            Colors.white), // เปลี่ยนสีข้อความ
                                  ),
                                ),
                              );
                            })),
                      ),
                    ],
                  );
                },
              )),
            ],
          ),
        ),
      );
    });
  }
}
