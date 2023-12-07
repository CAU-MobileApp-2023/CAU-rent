import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teamproject/model/UserSignupData.dart';
import 'package:teamproject/style.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'http://caurent.kro.kr:8000';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserSignupData userData = UserSignupData();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
          key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/CAU_rent.png',
                  height: 90,
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
                    key: const ValueKey(1),
                    keyboardType: TextInputType.emailAddress,

                    controller: emailController,

                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: AppColor.Blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      prefixIcon: const Icon(Icons.account_circle),
                      prefixIconColor: AppColor.Blue,
                    ),
                    onChanged: (value){
                      userData.email = value;
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
                    key: const ValueKey(2),

                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: AppColor.Blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: AppColor.Blue,
                    ),
                    obscureText: true,
                    onChanged: (value){
                      userData.password = value;
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                        color: AppColor.Blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      prefixIcon: const Icon(Icons.vpn_key),
                      prefixIconColor: AppColor.Blue,
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
                    key: const ValueKey(3),

                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                        color: AppColor.Blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: AppColor.Blue,
                    ),
                    onChanged: (value){
                      userData.name = value;
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
                    key: const ValueKey(4),
                    keyboardType: TextInputType.number,

                    controller: studentIdController,
                    decoration: InputDecoration(
                      labelText: 'Student ID',
                      labelStyle: const TextStyle(
                        color: AppColor.Blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      prefixIcon: const Icon(Icons.badge),
                      prefixIconColor: AppColor.Blue,
                    ),
                    onChanged: (value){
                      userData.studentId = value;
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
                    key: const ValueKey(5),
                    keyboardType: TextInputType.number,

                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: const TextStyle(
                        color: AppColor.Blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: AppColor.Blue),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor: AppColor.Blue,
                    ),
                    onChanged: (value){
                      userData.phoneNumber = value;
                    },
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String _email = emailController.text;
                      String _password = passwordController.text;
                      String _confirmPassword = confirmPasswordController.text;
                      String _name = nameController.text;
                      String _studentId = studentIdController.text;
                      String _phoneNumber = phoneController.text;

                      if (_email.isEmpty) {
                        _showSnackBar('Please enter your email', Colors.red);
                      } else if (_password.isEmpty) {
                        _showSnackBar('Please enter the password', Colors.red);
                      } else if (_confirmPassword.isEmpty) {
                        _showSnackBar('Please re-enter the password', Colors.red);
                      } else if (_name.isEmpty) {
                        _showSnackBar('Please enter your name', Colors.red);
                      } else if (_studentId.isEmpty) {
                        _showSnackBar('Please enter your student ID', Colors.red);
                      } else if (_phoneNumber.isEmpty) {
                        _showSnackBar('Please enter your phone number', Colors.red);
                      } else if (_password != _confirmPassword) {
                        _showSnackBar('Please re-confirm the password', Colors.red);
                      } else {

                        userData.department = '소프트웨어학부';
                        var result = await http.post(
                            Uri.parse('$baseUrl/users/signup/'),
                            body: jsonEncode(userData.toJson()),
                            headers: {'content-type': 'application/json'}
                        );
                        if (result.statusCode == 201) {
                          _showSnackBar('Successfully Signed Up', Colors.green);
                          Navigator.pop(context);
                        } else {
                          _showSnackBar('Failed to Sign Up', Colors.red);
                        }
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
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
