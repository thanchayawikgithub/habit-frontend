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

  // Edit a habit by its ID
  Future<void> editHabit(String id) async {
    try {
      final habit = Habit(
        id: id,
        title: titleCtrl.text,
        description: descriptionCtrl.text,
        period: int.parse(periodCtrl.text),
        dayOfweeks: dayOfWeeksValue,
      );

      await habitsCollection.doc(id).update(habit.toMap());

      await fetchHabits(); // Refresh the habits list
    } catch (e) {
      print('Error editing habit: $e');
    }
  }

  // Delete a habit by its ID
  Future<void> deleteHabit(String id) async {
    try {
      await habitsCollection.doc(id).delete();

      await fetchHabits(); // Refresh the habits list
    } catch (e) {
      print('Error deleting habit: $e');
    }
  }

  // Fetch habits from Firestore
  Future<void> fetchHabits() async {
    try {
      QuerySnapshot snapshot = await habitsCollection.get();

      // Clear the list and populate it with new data
      habitsList.clear();
      for (var doc in snapshot.docs) {
        // Convert Firestore document to Habit mode
        Habit habit = Habit.fromMap(doc.data() as Map<String, dynamic>);
        habit.id = doc.id;
        habitsList.add(habit);
      }
    } catch (e) {
      print('Error fetching habits: $e');
    }
  }

  void setEditedHabit(Habit habit) {
    titleCtrl.text = habit.title;
    descriptionCtrl.text = habit.description;
    periodCtrl.text = habit.period.toString();
    dayOfWeeksValue = habit.dayOfweeks;
  }

  void clearForm() {
    titleCtrl.text = '';
    descriptionCtrl.text = '';
    periodCtrl.text = '';
    dayOfWeeksValue = [];
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchHabits();
  }
}
