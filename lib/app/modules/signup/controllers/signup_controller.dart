import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
      print('User created successfully: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Weak password provided.');
      } else if (e.code == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error creating user: ${e.message}');
      }
    }
  }
}
