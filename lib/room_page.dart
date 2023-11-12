import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late Map<int, bool> projectRoomRentalStatus;

  final projectRooms = List.generate(5, (i) => i + 1);

  @override
  void initState() {
    super.initState();
    // 각 장비 대여 상태 저장
    projectRoomRentalStatus = { for (var item in projectRooms) item : item < 3 };
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 70),
              const Text("Room", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const TabBar(
                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  labelColor: AppColor.Blue,                // 선택된 탭의 색상
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3, color: AppColor.Blue),
                  ),
                  tabs: [
                    Tab(text: 'Team Project Room (208관 601호)'),
                  ]
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: projectRooms.map((i) => TextButton.icon(
                    onPressed: () {
                      print('TextButton Pressed!');
                    },
                    icon: Icon(Icons.forum_rounded, color: AppColor.Blue4),
                    label: Text(
                      'Team Project Room #$i',
                      style: TextStyle(fontSize: 20, color: AppColor.Blue4, fontWeight: FontWeight.bold),
                    ),
                  )).toList(),
                ),
              )
            ],
          ),
        )
    );
  }
}