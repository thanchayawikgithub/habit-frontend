import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  final signInEmailCtrl = TextEditingController();
  final signInPasswordCtrl = TextEditingController();
  final signUpDisplayNameCtrl = TextEditingController();
  final signUpEmailCtrl = TextEditingController();
  final signUpPasswordCtrl = TextEditingController();
  @override
  void onInit() {
    super.onInit();

    _auth.userChanges().listen((User? user) {
      this.user.value = user;
    });
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: signUpEmailCtrl.text,
        password: signUpPasswordCtrl.text,
      );

      await userCredential.user!.updateDisplayName(signUpDisplayNameCtrl.text);
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

  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: signInEmailCtrl.text,
        password: signInPasswordCtrl.text,
      );
      Get.toNamed('/home');
      print('User signed in successfully: ${userCredential.user}');
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
