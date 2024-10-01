import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/report/views/report_view.dart';
import 'package:habit_frontend/app/modules/report/views/widget/build_info.dart';
import 'package:habit_frontend/app/modules/report/views/widget/calender_widget.dart';

class GoalsDetail extends StatelessWidget {
  final ReportView report;
  final int index;
  GoalsDetail({super.key, required this.report, required this.index});

  @override
  Widget build(BuildContext context) {
    final reports = report.reportList.reportData[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals : ${reports.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: BuildInfo(
                index: index,
                report: report,
              ))),
    );
  }
}
