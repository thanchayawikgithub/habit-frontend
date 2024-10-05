import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';

class HabitDetailController extends GetxController {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');

  var habit = Habit(
    title: '',
    description: '',
    period: 0,
  ).obs;

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

  @override
  Future<void> onInit() async {
    super.onInit();

    // Retrieve the 'id' parameter from GetX arguments
    final String? habitId = Get.parameters['id'];

    // Fetch habit using the retrieved id
    if (habitId != null) {
      await fetchHabit(habitId);
    }
  }
}
