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
      Map<DateTime, String> habitStatusMap = {};
      for (var record in habit.habitRecords) {
        DateTime date = DateTime.parse(record.date);
        String status = record.status == 'Complete' || record.status == true
            ? 'Complete'
            : 'Pending';
        habitStatusMap[date] = status; // เก็บสถานะใน Map
      }

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(2010, 10, 16),
                lastDay: DateTime(2030, 3, 14),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false, // ซ่อนปุ่ม "2 weeks"
                  titleCentered: true, // จัดกลางหัวข้อ
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (date.isSameDate(DateTime.now()) ||
                        date.isAfter(DateTime.now())) {
                      return null;
                    }

                    for (var recordDate in habitStatusMap.keys) {
                      if (recordDate.isSameDate(date)) {
                        String status = habitStatusMap[recordDate]!;
                        Color color =
                            (status == 'Complete') ? Colors.green : Colors.red;

                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            width: 30,
                            height: 30,
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    return null;
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Complete',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6), // ระยะห่างภายใน
                    decoration: BoxDecoration(
                      color: Colors.green, // สีพื้นหลัง
                      shape: BoxShape.circle, // รูปทรงกลม
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Missing',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6), // ระยะห่างภายใน
                    decoration: BoxDecoration(
                      color: Colors.red, // สีพื้นหลัง
                      shape: BoxShape.circle, // รูปทรงกลม
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Pending',
                  style: TextStyle(fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    padding: EdgeInsets.all(6), // ระยะห่างภายใน
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 183, 171, 248), // สีพื้นหลัง
                      shape: BoxShape.circle, // รูปทรงกลม
                    ),
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
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  habit.title,
                  style: const TextStyle(fontSize: 20),
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
              height: 5,
            ),
          ]),
        ),
      );
    });
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime date) {
    return this.year == date.year &&
        this.month == date.month &&
        this.day == date.day;
  }
}
