import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:uuid/uuid.dart';

class HabitsController extends GetxController {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');

  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final periodCtrl = TextEditingController();

  List<String> dayOfWeeksValue = [];
  var habitsList = <Habit>[].obs; // Observable list to store habits

  Future<void> addHabit() async {
    try {
      final habit = Habit(
          id: Uuid().v4(),
          title: titleCtrl.text,
          description: descriptionCtrl.text,
          period: int.parse(periodCtrl.text),
          dayOfweeks: dayOfWeeksValue);

      await habitsCollection.add(habit.toMap());

      await fetchHabits();
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  // Fetch habits from Firestore
  Future<void> fetchHabits() async {
    try {
      QuerySnapshot snapshot = await habitsCollection.get();

      // Clear the list and populate it with new data
      habitsList.clear();
      for (var doc in snapshot.docs) {
        // Convert Firestore document to Habit model
        Habit habit = Habit.fromMap(doc.data() as Map<String, dynamic>);
        habitsList.add(habit);
      }
    } catch (e) {
      print('Error fetching habits: $e');
    }
  }

  // Optionally, you can use a real-time listener with snapshots
  void listenToHabits() {
    habitsCollection.snapshots().listen((snapshot) {
      habitsList.clear(); // Clear list before adding new data
      for (var doc in snapshot.docs) {
        Habit habit = Habit.fromMap(doc.data() as Map<String, dynamic>);
        habitsList.add(habit);
      }
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchHabits();
  }
}
