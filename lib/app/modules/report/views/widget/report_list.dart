import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_frontend/app/modules/report/report.dart';

// ignore: must_be_immutable
class ReportList extends GetxService {
  final List<Report> reportData = [
    Report(
      id: 1,
      title: 'Journaling everyday',
      progress: 100,
      target: '7 from 7 days target',
      status: 'Achieved',
    ),
    Report(
      id: 2,
      title: 'Cooking Practice',
      progress: 100,
      target: '7 from 7 days target',
      status: 'Achieved',
    ),
    Report(
      id: 3,
      title: 'Vitamin',
      progress: 70,
      target: '5 from 7 days target',
      status: 'Unachieved',
    ),
    Report(
      id: 4,
      title: 'Exercise',
      progress: 90,
      target: '6 from 7 days target',
      status: 'Unachieved',
    ),
    Report(
      id: 5,
      title: 'Meditation',
      progress: 60,
      target: '4 from 7 days target',
      status: 'Achieved',
    ),
    Report(
      id: 6,
      title: 'Reading Books',
      progress: 80,
      target: '5 from 7 days target',
      status: 'Achieved',
    ),
  ];

  void indexReport(int index, Report Report) {
    reportData[index] = Report;
  }
}
