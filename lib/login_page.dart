import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamproject/main.dart';
import 'package:teamproject/model/UserLoginData.dart';
import 'package:teamproject/provider/User.dart';
import 'package:teamproject/signup_page.dart';
import 'package:teamproject/style.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  UserLoginData userData = UserLoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: logInScreen(),
      ),
    );
  }

  Widget logInScreen() {
    final _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
      key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/CAU_rent.png',
                height: 120,
              ),
            ),

            /*
            const Text(
              'CAU rent',
              style: TextStyle(fontSize: 28, color: AppColor.Blue, fontWeight: FontWeight.bold),
            ),
             */

            /* ----------------------------------- */
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                'CAU rent',
                style: TextStyle(fontSize: 28, color: AppColor.Blue, fontWeight: FontWeight.bold),
              ),
            ),
            /* ----------------------------------- */
            const SizedBox(height: 20),

            SizedBox(
              width: 280,
              child: TextFormField(
                key: const ValueKey(1),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: '이메일을 입력하세요',
                  labelStyle: TextStyle(
                    color: AppColor.Blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.Blue,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value){
                  userData.email = value;
                },
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: 280,
              child: TextFormField(
                key: const ValueKey(2),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: '비밀번호를 입력하세요',
                  labelStyle: TextStyle(
                    color: AppColor.Blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.Blue,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
                onChanged: (value){
                  userData.password = value;
                },
              ),
            ),

            const SizedBox(height: 60),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var result = await http.post(
                      Uri.parse('http://10.0.2.2:8000/users/login/'),
                      body: jsonEncode(userData.toJson()),
                      headers: {'content-type': 'application/json'}
                  );
                  if (result.statusCode == 200) {
                    Map<String, dynamic> responseData = json.decode(result.body);
                    _handleLoginSuccess(responseData);
                  } else if (result.statusCode == 404) {
                    _showSnackBar('Email address does not exist', Colors.red);
                  } else if (result.statusCode == 401) {
                    _showSnackBar('Password is not correct', Colors.red);
                  } else {
                    _showSnackBar('Failed to Log In', Colors.red);
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                fixedSize: MaterialStateProperty.all<Size>(const Size(280, 50)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )
                ),
              ),
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(height: 18),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
                side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppColor.Blue)),
                fixedSize: MaterialStateProperty.all<Size>(const Size(280, 50)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginSuccess(Map<String, dynamic> responseData) {
    context.read<UserProvider>().setUserEmail(responseData['user_data']['email']);
    context.read<UserProvider>().setUserName(responseData['user_data']['name']);
    context.read<UserProvider>().setUserStudentId(responseData['user_data']['student_id']);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
