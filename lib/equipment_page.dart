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

  static const TextStyle iconTextStyle = TextStyle(fontSize: 16, color: AppColor.Blue4, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 70),
              const Text("Equipment", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
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
                        children: macBooks.map((i) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showAlertDialog(context, "MacBook", i);
                              },
                              icon: const Icon(Icons.laptop_mac, color: AppColor.Blue4),
                              iconSize: 65,
                              padding: EdgeInsets.zero,
                            ),
                            Text("#$i", style: iconTextStyle),
                          ],
                        )).toList(),
                      ),
                      GridView.count(
                        crossAxisCount: 4,
                        children: lgGrams.map((i) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showAlertDialog(context, "LG Gram", i);
                              },
                              icon: const Icon(Icons.laptop_windows, color: AppColor.Blue4),
                              iconSize: 65,
                              padding: EdgeInsets.zero,
                            ),
                            Text("#$i", style: iconTextStyle),
                          ],
                        )).toList(),
                      ),
                      GridView.count(
                        crossAxisCount: 4,
                        children: webCams.map((i) => Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showModalBottomSheet(context, "WebCam", i);
                              },
                              icon: const Icon(Icons.photo_camera, color: AppColor.Blue4),
                              iconSize: 65,
                              padding: EdgeInsets.zero,
                            ),
                            Text("#$i", style: iconTextStyle),
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

  void _showModalBottomSheet(BuildContext context, String equipmentType, int equipmentNum) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 480,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            color: AppColor.Blue1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$equipmentType #$equipmentNum',
                style: const TextStyle(fontSize: 32, color: AppColor.Blue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(width: 340, height: 180, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                '대여하시겠습니까?',
                style: TextStyle(fontSize: 32, color: AppColor.Blue4, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Do you want to rent?',
                style: TextStyle(fontSize: 20, color: AppColor.Blue4, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      // equipmentType, equipmentNum
                      Navigator.of(context).pop(); // AlertDialog 닫기
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue3),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(140, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // 버튼의 모서리를 둥글게
                          )
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // AlertDialog 닫기
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(AppColor.Blue3),
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(color: AppColor.Blue3, width: 2.0)),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(140, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // 버튼의 모서리를 둥글게
                          )
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, String equipmentType, int equipmentNum) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
              child: Text(
                '$equipmentType #$equipmentNum',
                style: const TextStyle(fontSize: 30, color: AppColor.Blue, fontWeight: FontWeight.bold),
              )
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('현재 대여 중인 장비입니다.'),
              const Text(
                'This equipment is not available for rent now.',
                style: TextStyle(fontSize: 14.4),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // AlertDialog 닫기
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue3),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(140, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // 버튼의 모서리를 둥글게
                          )
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}