part of 'app_pages.dart';

// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart
int index = 0;

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const HABITS = _Paths.HABITS;

  static const PROFILE = _Paths.PROFILE;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const GOALS = _Paths.GOALS;
  static const HABIT = _Paths.HABIT;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const HABITS = '/habits';
  static const HABIT = '/habits/:id';
  static const PROFILE = '/profile';

  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const GOALS = '/goals';
}
