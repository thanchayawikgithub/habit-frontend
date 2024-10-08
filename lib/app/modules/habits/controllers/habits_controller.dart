import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/data/models/habit.dart';
import 'package:habit_frontend/app/data/models/habit_record.dart';
import 'package:habit_frontend/app/services/local_notification.dart';
import 'package:intl/intl.dart';

class HabitsController extends GetxController {
  final cron = Cron();
  final Map<String, ScheduledTask> scheduledJobs = {};
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');
  final CollectionReference habitRecordsCollection =
      FirebaseFirestore.instance.collection('habit_records');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  Rx<String?> reminderTime = Rx<String?>(null);
  Rx<IconData?> selectedIcon = Rx<IconData?>(null);
  Rx<Color> selectedColor = Rx<Color>(Colors.black);
  var habitsList = <Habit>[].obs; // Observable list to store habits
  var habitRecordsList = <HabitRecord>[].obs; // Observable list to store habits
  var habit = Habit(
          title: '',
          description: '',
          icon: null,
          habitRecords: [],
          id: null,
          userId: null,
          reminderTime: null,
          color: Colors.black)
      .obs;

  Future<void> addHabit() async {
    try {
      final habit = Habit(
          title: titleCtrl.text,
          description: descriptionCtrl.text,
          userId: _auth.currentUser?.uid ?? '',
          habitRecords: [],
          icon: selectedIcon.value,
          reminderTime: reminderTime.value,
          color: selectedColor.value);

      final savedHabitRef = await habitsCollection.add(habit.toMap());
      final savedHabitDoc = await savedHabitRef.get();
      if (savedHabitDoc.exists) {
        Habit savedHabit =
            Habit.fromMap(savedHabitDoc.data() as Map<String, dynamic>);
        savedHabit.id = savedHabitDoc.id;
        final DateTime today = DateTime.now();
        final DateFormat formatter =
            DateFormat('yyyy-MM-dd'); // Specify the format
        final String formattedDate = formatter.format(today);
        final habitRecord =
            HabitRecord(habitId: savedHabit.id!, date: formattedDate);
        await habitRecordsCollection.add(habitRecord.toMap());

        if (savedHabit.reminderTime != null) {
          _registerReminder(savedHabit);
        }
      }

      await fetchHabits();
      await fetchTodayHabits();
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  // Edit a habit by its ID
  Future<void> editHabit(String id) async {
    try {
      await habitsCollection.doc(id).update({
        'title': titleCtrl.text,
        'description': descriptionCtrl.text,
        'icon': selectedIcon.value?.codePoint,
        'reminderTime': reminderTime.value,
        'color': selectedColor.value.value
      });

      DocumentSnapshot updatedDoc = await habitsCollection.doc(id).get();
      if (updatedDoc.exists) {
        Habit updatedHabit =
            Habit.fromMap(updatedDoc.data() as Map<String, dynamic>);
        updatedHabit.id = updatedDoc.id;
        stopReminder(updatedDoc.id);
        _registerReminder(updatedHabit);
      }

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
      stopReminder(id);
    } catch (e) {
      print('Error deleting habit: $e');
    }
  }

  // Fetch habits from Firestore
  Future<void> fetchHabits() async {
    print("fetch habits");
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

  Future<void> fetchTodayHabits() async {
    print('fetch today habits');
    List<HabitRecord> habitRecordsInstance = [];
    try {
      // Fetch habits for the current user
      QuerySnapshot habitSnapshot = await habitsCollection
          .where('userId', isEqualTo: _auth.currentUser?.uid ?? '')
          .get();

      // Get today's date and format it
      final DateTime today = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedDate = formatter.format(today);

      // Clear the list before fetching new data

      // Loop through each habit and fetch the corresponding records
      for (var habitDoc in habitSnapshot.docs) {
        final String habitId = habitDoc.id; // Get the habitId from the document

        Habit habit = Habit.fromMap(habitDoc.data() as Map<String, dynamic>);
        habit.id = habitDoc.id;
        // Fetch records for today's date and the current habitId
        QuerySnapshot habitRecSnapshot = await habitRecordsCollection
            .where('date', isEqualTo: formattedDate)
            .where('habitId',
                isEqualTo: habitId) // Use the habitId from the document
            .get();

        // Populate the habitRecordsList with the retrieved records

        for (var doc in habitRecSnapshot.docs) {
          print('Habit record docs${doc.id}');
          HabitRecord habitRecord =
              HabitRecord.fromMap(doc.data() as Map<String, dynamic>);
          habitRecord.id = doc.id; // Set the id of the HabitRecord
          habitRecord.habit = habit;
          habitRecordsInstance.add(habitRecord);
        }
      }
      habitRecordsList.value = habitRecordsInstance;
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
        List<HabitRecord> habitRecordsInstance = [];
        // Convert Firestore document to Habit model
        Habit habit = Habit.fromMap(doc.data() as Map<String, dynamic>);
        habit.id = doc.id;

        QuerySnapshot habitRecSnapshot = await habitRecordsCollection
            .where('habitId',
                isEqualTo: habit.id) // Use the habitId from the document
            .get();

        // Populate the habitRecordsList with the retrieved records

        for (var doc in habitRecSnapshot.docs) {
          print('Habit record docs${doc.id}');
          HabitRecord habitRecord =
              HabitRecord.fromMap(doc.data() as Map<String, dynamic>);
          habitRecord.id = doc.id; // Set the id of the HabitRecord
          habitRecord.habit = habit;
          habitRecordsInstance.add(habitRecord);
        }

        habit.habitRecords = habitRecordsInstance;
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
    selectedIcon.value = habit.icon;
    reminderTime.value = habit.reminderTime;
    selectedColor.value = habit.color;
  }

  void clearForm() {
    titleCtrl.text = '';
    descriptionCtrl.text = '';
    selectedIcon.value = null;
    reminderTime.value = null;
    selectedColor.value = Colors.black;
  }

  TimeOfDay timeFromString(String timeString) {
    // Split the string into hour and minute parts
    List<String> parts = timeString.split(':');

    // Parse the hour and minute
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Create and return a TimeOfDay object
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> changeHabitRecordStatus(HabitRecord habitRecord) async {
    habitRecord.status = !habitRecord.status;
    await habitRecordsCollection
        .doc(habitRecord.id)
        .update(habitRecord.toMap());
    await fetchTodayHabits();
  }

  Future<void> createDailyHabitsRecord() async {
    print('create daily habit record');
    QuerySnapshot habitSnapshot = await habitsCollection.get();

    final DateTime today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(today);

    for (var habitDoc in habitSnapshot.docs) {
      final String habitId = habitDoc.id; // Get the habitId from the document
      final habitRecord = HabitRecord(habitId: habitId, date: formattedDate);
      await habitRecordsCollection.add(habitRecord.toMap());
    }
  }

  void _registerReminder(Habit habit) {
    print('register reminder');
    print(habit);
    // Create a unique identifier for the habit (you could use habit.id or something unique)
    String cronId = habit.id!;

    // Assuming habit.reminderTime is in 'HH:mm' format
    List<String> timeParts = habit.reminderTime!.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Schedule the cron job to run daily at the specific time
    scheduledJobs[cronId] =
        cron.schedule(Schedule.parse('$minute $hour * * *'), () async {
      LocalNotifications.showSimpleNotification(
        title: 'Habit Reminder',
        body: "It's Time To ${habit.title}!",
        payload: "It's Time To ${habit.title}!",
      );
    });
  }

// Function to stop a specific cron job by its identifier
  void stopReminder(String cronId) {
    if (scheduledJobs.containsKey(cronId)) {
      scheduledJobs[cronId]?.cancel();
      scheduledJobs.remove(cronId); // Remove from map after stopping
      print('Cron job with ID $cronId stopped.');
    } else {
      print('No cron job found with ID $cronId.');
    }
  }
}
