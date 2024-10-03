import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/home/views/my_goals_detail.dart';
import 'package:habit_frontend/app/modules/home/widgets/my_goal.dart';

import '../modules/habits/bindings/habits_binding.dart';
import '../modules/habits/views/habits_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/report.dart';
import '../modules/report/views/goals_detail.dart';
import '../modules/report/views/goals_view.dart';
import '../modules/report/views/report_view.dart';
import '../modules/report/views/widget/report_list.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PROFILE;
  static late ReportList reportList;
  static late Report reports;
  static final routes = [
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: _Paths.HABITS,
      page: () => HabitsView(),
      binding: HabitsBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS,
      page: () => ReportView(ReportList()),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.GOALS,
      page: () => GoalsView(
        report: ReportList(),
      ),
      binding: ReportBinding(),
    ),
    //goals_detail
    GetPage(
      name: _Paths.GOALSDETAIL,
      page: () => GoalsDetail(
        report: ReportView(ReportList()),
        index: int.parse(Get.parameters['id']!),
      ),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.MYGOAL,
      page: () => MyGoalsDetail(),
      binding: HomeBinding(),
    ),
  ];
}
