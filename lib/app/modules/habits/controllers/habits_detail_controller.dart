import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HabitDetailController extends GetxController {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');
}
