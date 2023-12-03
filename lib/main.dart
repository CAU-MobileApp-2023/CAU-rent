import 'package:flutter/material.dart';
import 'package:teamproject/notice_page.dart';
import 'package:teamproject/login_page.dart';
import 'package:teamproject/room_page.dart';
import 'package:teamproject/style.dart';
import 'package:teamproject/equipment_page.dart';
import 'package:teamproject/mypage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LogInPage(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  static final List<Widget> _pages = <Widget>[
    const NoticePage(),
    const EquipmentPage(),
    const RoomPage(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedPage),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          iconSize: 35,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(Icons.circle_notifications_outlined),
              ),
              label: 'Notice',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(Icons.build_circle_outlined),
              ),
              label: 'Equipment',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(Icons.supervised_user_circle_outlined),
              ),
              label: 'Room',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(Icons.account_circle_outlined),
              ),
              label: 'My Page',
            ),
          ],
          currentIndex: _selectedPage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.Blue,
          unselectedItemColor: AppColor.Grey,
          selectedLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
