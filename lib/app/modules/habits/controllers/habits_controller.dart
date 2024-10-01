import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HabitsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData() async {
    try {
      await _firestore.collection('habits').add({
        'field1': 'value1',
        'field2': 'value2',
      });
    } catch (e) {
      print('Error adding data: $e');
    }
  }
  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
