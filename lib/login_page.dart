import 'package:flutter/material.dart';
import 'package:teamproject/main.dart';
import 'package:teamproject/style.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  Map<String, Map<String, String>> users = {};

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoggedIn ? HomePage() : LogInScreen(),
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
            padding: const EdgeInsets.all(10.0),
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
          Container(
            width: 300,
            child: TextField(
              controller: emailController,
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
          SizedBox(height: 16),
          Container(
            width: 300,
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
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _navigateToRegister(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
              side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppColor.Blue)),
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
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
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    if (enteredEmail.isNotEmpty && enteredPassword.isNotEmpty) {
      if (users.containsKey(enteredEmail) &&
          users[enteredEmail]!['password'] == enteredPassword) {
        _showSnackBar('로그인이 성공했습니다', Colors.green);
        setState(() {
          isLoggedIn = true;
        });
      } else {
        _showSnackBar('이메일 또는 비밀번호가 잘못되었습니다', Colors.red);
      }
    } else {
      _showSnackBar('모든 입력 필드를 작성하세요', Colors.red);
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen(users)),
    );
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

class RegisterScreen extends StatefulWidget {
  final Map<String, Map<String, String>> users;

  RegisterScreen(this.users);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
            ),
            Container(
              width: 500,
              child: TextField(
                controller: registerEmailController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 500,
              child: TextField(
                controller: registerPasswordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 500,
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Password Check',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 500,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 500,
              child: TextField(
                controller: studentIdController,
                decoration: InputDecoration(
                  labelText: 'Student ID',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _performRegistration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Sign Up', style: TextStyle(color: Colors.blue)),
                  SizedBox(width: 8.0),
                ],
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(500, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performRegistration() {
    String newEmail = registerEmailController.text;
    String newPassword = registerPasswordController.text;
    String confirmPassword = confirmPasswordController.text;
    String name = nameController.text;
    String studentId = studentIdController.text;

    if (newEmail.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        name.isNotEmpty &&
        studentId.isNotEmpty) {
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
