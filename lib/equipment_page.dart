import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class EquipmentPage extends StatefulWidget {
  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final dogs = List.generate(41, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Text("Equipment", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              ),
              TabBar(
                  labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  labelColor: AppColor.Blue,                // 선택된 탭의 색상
                  unselectedLabelColor: AppColor.Blue2,     // 선택되지 않은 탭의 색상
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2, color: AppColor.Blue),
                  ),
                  tabs: [
                    Tab(text: 'MacBook'),
                    Tab(text: 'LG gram'),
                    Tab(text: 'WebCam'),
                  ]
              ),
              Expanded(
                  child: TabBarView(
                    children: [
                      GridView.count(
                        crossAxisCount: 3,
                        children: dogs.map((i) => Image(image: AssetImage('assets/dog_$i.jpeg'))).toList(),
                      ),
                      Center(
                        child: Text('첫 번째 탭 내용'),
                      ),
                      Center(
                        child: Text('두 번째 탭 내용'),
                      ),
                      Center(
                        child: Text('세 번째 탭 내용'),
                      ),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
