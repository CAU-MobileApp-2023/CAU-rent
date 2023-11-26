import 'package:flutter/material.dart';
import 'package:teamproject/room_page.dart';
import 'package:teamproject/style.dart';
import 'package:teamproject/equipment_page.dart';
import 'package:teamproject/myPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // primaryColor: Colors.blue,
          // primarySwatch: Colors.indigo
      ),
      home: const HomePage(),
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
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const Text('Index 0: Home', style: optionStyle),
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
      // appBar: AppBar(
      //   title: const Text('CAU rent'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedPage),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          iconSize: 35,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(Icons.circle_notifications_outlined),
              ),
              label: 'Home',
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
