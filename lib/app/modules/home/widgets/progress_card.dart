import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.75;
    return Card(
      color: Colors.deepPurple[600],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 120, // Adjust to increase size
                    height: 120, // Adjust to increase size
                    child: FittedBox(
                      // Use FittedBox to scale the CircularProgressIndicator
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progressValue,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                            strokeWidth: 5, // Adjust thickness as needed
                          ),
                          Center(
                            child: Text(
                              '${(progressValue * 100).toInt()}%',
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
