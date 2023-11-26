import 'package:flutter/material.dart';
import 'package:teamproject/main.dart';
import 'package:teamproject/signup_page.dart';
import 'package:teamproject/style.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  Map<String, Map<String, String>> users = {};

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoggedIn ? const HomePage() : LogInScreen(),
      ),
    );
  }

  Widget LogInScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/CAU_rent.png', // 로고 넣어야 할 곳
              height: 120,
            ),
          ),
          const Text(
            'CAU rent',
            style: TextStyle(fontSize: 28, color: AppColor.Blue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 280,
            child: TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'ID',
                hintText: '아이디를 입력하세요',
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
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 280,
            child: TextField(
              controller: passwordController,
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
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () => _performLogin(),
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
                MaterialPageRoute(builder: (context) => SignUpPage(users)),
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _performLogin() {
    String enteredId = idController.text;
    String enteredPassword = passwordController.text;

    if (enteredId.isNotEmpty && enteredPassword.isNotEmpty) {
      if (users.containsKey(enteredId) && users[enteredId]!['password'] == enteredPassword) {
        _showSnackBar('로그인이 성공했습니다', Colors.green);
        setState(() {
          isLoggedIn = true;
        });
      } else {
        _showSnackBar('아이디 또는 비밀번호가 잘못되었습니다', Colors.red);
      }
    } else if (enteredId.isEmpty) {
      _showSnackBar('아이디를 입력하세요', Colors.red);
    } else if (enteredPassword.isEmpty) {
      _showSnackBar('비밀번호를 입력하세요', Colors.red);
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
