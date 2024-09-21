import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_frontend/app/layout/bottom_app_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBarWidget(),
        body: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 60.0),
            child: Column(
              children: [
                Center(
                    child: Card(
                  color: Colors.purple, // Set the card color to purple
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Set the card width to the screen width
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Full Width Card',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'This card takes up the full width of the screen.',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            )));
  }
}
