import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  // เปลี่ยนจาก GetView เป็น StatefulWidget
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isRememberMeChecked = false; // กำหนดตัวแปรเพื่อจัดการสถานะของ Checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7), // Background color ตามภาพ
      body: SafeArea(
        child: SingleChildScrollView(
          // เพิ่ม SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20), // ระยะห่างจากด้านบนสุดของ SafeArea
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // จัดตำแหน่งระหว่าง Log In และ Sign Up
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Sign Up page
                        Get.toNamed('/signup'); // เปลี่ยนลิงก์ไปหน้าสมัคร
                      },
                      child: Row(
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30), // ระยะห่างจาก Row ข้อความ Log In

                // ชื่อ Email
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none, // ไม่มีเส้นขอบ
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
                SizedBox(height: 16),

                // ชื่อ Password
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none, // ไม่มีเส้นขอบ
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
                SizedBox(height: 16),

                // Row ของ Remember me และ Forgot Password?
                Row(
                  children: [
                    // Remember me
                    Row(
                      children: [
                        Checkbox(
                          value: isRememberMeChecked, // ค่าเริ่มต้น
                          onChanged: (value) {
                            setState(() {
                              isRememberMeChecked =
                                  value ?? false; // อัปเดตสถานะ Checkbox
                            });
                          },
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // ระยะห่างระหว่าง Remember me และ Forgot Password?
                    // Forgot Password?
                    GestureDetector(
                      onTap: () {
                        // กำหนดฟังก์ชันว่างเปล่าไว้
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6E33FF),
                        Color(0xFFB44AC3),
                        Color(0xFFCE62CF)
                      ], // สีตามในรูป
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // เมื่อกดปุ่ม Log In จะไปหน้าที่กำหนด
                      Get.toNamed('/habit'); // เปลี่ยนลิงก์ไปหน้า habit
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // ตั้งค่าพื้นหลังโปร่งใส
                      shadowColor: Colors.transparent, // ตั้งค่าเงาโปร่งใส
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40), // ระยะห่างระหว่างปุ่มและขอบล่าง
              ],
            ),
          ),
        ),
      ),
    );
  }
}
