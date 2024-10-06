import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/data/models/habit_record.dart';
import 'package:intl/intl.dart';

class HabitsController extends GetxController {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');
  final CollectionReference habitRecordsCollection =
      FirebaseFirestore.instance.collection('habit_records');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final periodCtrl = TextEditingController();

  List<String> dayOfWeeksValue = [];
  var habitsList = <Habit>[].obs; // Observable list to store habits
  var habitRecordsList = <HabitRecord>[].obs; // Observable list to store habits
  var habit = Habit(
    title: '',
    description: '',
    period: 0,
  ).obs;
  Future<void> addHabit() async {
    try {
      final habit = Habit(
          title: titleCtrl.text,
          description: descriptionCtrl.text,
          period: int.parse(periodCtrl.text),
          userId: _auth.currentUser?.uid ?? '');

      final savedHabit = await habitsCollection.add(habit.toMap());

      final DateTime today = DateTime.now();
      final DateFormat formatter =
          DateFormat('yyyy-MM-dd'); // Specify the format
      final String formattedDate = formatter.format(today);
      final habitRecord =
          HabitRecord(habitId: savedHabit.id, date: formattedDate);
      await habitRecordsCollection.add(habitRecord.toMap());

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
      QuerySnapshot snapshot = await habitsCollection
          .where('userId', isEqualTo: _auth.currentUser?.uid ?? '')
          .get();

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

  Future<void> fetchHabitRecords() async {
    try {
      final DateTime today = DateTime.now();
      final DateFormat formatter =
          DateFormat('yyyy-MM-dd'); // Specify the format
      final String formattedDate = formatter.format(today);
      QuerySnapshot snapshot = await habitRecordsCollection
          .where('date', isEqualTo: formattedDate)
          .get();

      // Clear the list and populate it with new data
      habitRecordsList.clear();
      for (var doc in snapshot.docs) {
        // Convert Firestore document to Habit mode
        HabitRecord habitRecord =
            HabitRecord.fromMap(doc.data() as Map<String, dynamic>);
        habitRecord.id = doc.id;
        habitRecordsList.add(habitRecord);
      }

      print(habitRecordsList.toJson());
    } catch (e) {
      print('Error fetching habits: $e');
    }
  }

  Future<void> fetchHabit(String id) async {
    try {
      // Fetch the document with the specific id
      DocumentSnapshot doc = await habitsCollection.doc(id).get();

      if (doc.exists) {
        // Convert Firestore document to Habit model
        Habit habit = Habit.fromMap(doc.data() as Map<String, dynamic>);
        habit.id = doc.id;

        this.habit.value = habit;
      } else {
        print('No habit found with id: $id');
      }
    } catch (e) {
      print('Error fetching habit: $e');
    }
  }

  void setEditedHabit(Habit habit) {
    titleCtrl.text = habit.title;
    descriptionCtrl.text = habit.description;
    periodCtrl.text = habit.period.toString();
  }

  void clearForm() {
    titleCtrl.text = '';
    descriptionCtrl.text = '';
    periodCtrl.text = '';
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchHabits();
  }
}
