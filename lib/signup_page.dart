import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class SignUpPage extends StatefulWidget {
  final Map<String, Map<String, String>> users;

  const SignUpPage(this.users, {super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                  'assets/CAU_rent.png', // 로고 넣어야 할 곳
                  height: 90,
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
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
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
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
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
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
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 280,
                  height: 45,
                  child: TextFormField(
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
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 폼 검증 성공 시 회원가입 수행
                      _performRegistration();
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

  void _performRegistration() {
    String newEmail = emailController.text;
    String newPassword = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String name = nameController.text;
    String studentId = studentIdController.text;
    String phoneNumber = phoneController.text;

    if (newEmail.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        name.isNotEmpty &&
        studentId.isNotEmpty &&
        phoneNumber.isNotEmpty) {
      if (newPassword == confirmPassword) {
        widget.users[newEmail] = {
          'password': newPassword,
          'name': name,
          'studentId': studentId,
        };

        _showSnackBar('회원가입에 성공했습니다', Colors.green);

        Navigator.pop(context);
      } else {
        _showSnackBar('비밀번호가 일치하지 않습니다', Colors.red);
      }
    } else {
      _showSnackBar('모든 입력 필드를 작성하세요', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
