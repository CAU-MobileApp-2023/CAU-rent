import 'package:flutter/material.dart';
import 'package:teamproject/room_page.dart';
import 'package:teamproject/style.dart';
import 'package:teamproject/equipment_page.dart';

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
      home: HomePage(),
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
    EquipmentPage(),
    RoomPage(),
    // const Text('Index 2: Rooms', style: optionStyle),
    const Text('Index 3: My Page', style: optionStyle),
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
                child: Icon(Icons.home_outlined),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(Icons.desktop_mac_outlined),
              ),
              label: 'Equipment',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                // child: Icon(Icons.comment_outlined),
                child: Icon(Icons.comment_outlined),
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
