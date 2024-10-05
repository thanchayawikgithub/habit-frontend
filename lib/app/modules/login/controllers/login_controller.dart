import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      final d = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      print(d);

      // Successful login, navigate to next screen or perform other actions
      // Get.toNamed('/habit');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = 'Login failed: ${e.message}';
    } finally {
      isLoading.value = false;
    }
  }
}
