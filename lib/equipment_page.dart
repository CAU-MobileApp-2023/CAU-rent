import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final macBooks = List.generate(27, (i) => i + 1);
  final lgGrams = List.generate(26, (i) => i + 1);
  final webCams = List.generate(130, (i) => i + 1);

  static const TextStyle iconTextStyle = TextStyle(fontSize: 15, color: AppColor.Blue4, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 70),
              const Text("Equipment", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const TabBar(
                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        crossAxisCount: 4,
                        children: webCams.map((i) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () { },
                              icon: const Icon(Icons.laptop_mac, color: AppColor.Blue4),
                              iconSize: 65,
                              padding: EdgeInsets.zero,
                            ),
                            Text("#${i}", style: iconTextStyle),
                          ],
                        )).toList(),
                      ),
                      GridView.count(
                        crossAxisCount: 4,
                        children: webCams.map((i) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () { },
                              icon: const Icon(Icons.laptop_windows, color: AppColor.Blue4),
                              iconSize: 65,
                              padding: EdgeInsets.zero,
                            ),
                            Text("#${i}", style: iconTextStyle),
                          ],
                        )).toList(),
                      ),
                      GridView.count(
                        crossAxisCount: 4,
                        children: webCams.map((i) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () { },
                              icon: const Icon(Icons.photo_camera, color: AppColor.Blue4),
                              iconSize: 65,
                              padding: EdgeInsets.zero,
                            ),
                            Text("#${i}", style: iconTextStyle),
                          ],
                        )).toList(),
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
