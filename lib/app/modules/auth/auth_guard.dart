import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is authenticated
    final currentUser = FirebaseAuth.instance.currentUser;
    print('current user $currentUser');
    // If the user is not authenticated, redirect to the login page
    if (currentUser == null) {
      return RouteSettings(name: '/login');
    }

    // Otherwise, proceed to the route
    return null;
  }
}
