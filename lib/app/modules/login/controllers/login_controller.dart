import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
      print('User signed in successfully: ${userCredential.user}');
      Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Error signing in: ${e.message}');
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print('User signed out successfully.');
  }
}
