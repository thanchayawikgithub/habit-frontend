import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';

class HabitsController extends GetxController {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');

  Future<void> addData(Habit habit) async {
    try {
      await habitsCollection.add(habit.toMap());
    } catch (e) {
      print('Error adding data: $e');
    }
  }
}
