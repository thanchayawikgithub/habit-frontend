import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/report/views/report_view.dart';
import 'package:habit_frontend/app/modules/report/views/widget/calender_widget.dart';

class BuildInfo extends StatelessWidget {
  const BuildInfo({Key? key, required this.report, required this.index})
      : super(key: key);
  final ReportView report;
  final int index;
  @override
  Widget build(BuildContext context) {
    final reports = report.reportList.reportData[index];
    return Column(
      children: [
        CalenderWidget(),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${reports.title} 7 Day',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: reports.status == 'Achieved'
                    ? Colors.green[100]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    reports.status,
                    style: TextStyle(
                      color: reports.status == 'Achieved'
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hbbit Name : ",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              reports.title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Target:",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "Tar",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Days completed:",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "completed",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Days failed: ",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "0 Day",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Habit type",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "Everyday",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Created on",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            Text(
              "June 4 2022",
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
