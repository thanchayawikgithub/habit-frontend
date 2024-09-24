import 'package:flutter/material.dart';
import 'package:habit_frontend/app/modules/report/views/report_view.dart';

class GoalsDetail extends StatelessWidget {
  final ReportView report;
  final int index;
  const GoalsDetail({super.key, required this.report, required this.index});

  @override
  Widget build(BuildContext context) {
    final reports = report.reportList.reportData[index];
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals : ${reports.title}',
            style: const TextStyle(fontSize: 24)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goals : ${reports.title}',
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Hbbit Name : ",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
