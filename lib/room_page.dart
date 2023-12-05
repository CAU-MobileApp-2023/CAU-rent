import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';


class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  //late Map<int, bool> projectRoomRentalStatus;
  //final projectRooms = List.generate(5, (i) => i + 1);

  final _rooms =['--선택해 주세요--','팀프로젝트실1 (208관 601호)','팀프로젝트실2 (208관 601호)','팀프로젝트실3 (208관 601호)','팀프로젝트실4 (208관 601호)','팀프로젝트실5 (208관 601호)'];
  String? _selectedRoom;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedRoom=_rooms[0];
    });
    // 각 팀플룸 대여 상태 저장
    // projectRoomRentalStatus = { for (var item in projectRooms) item : item % 2 == 0 };
  }

  String getTomorrow(){ // 예약 날짜(내일) 받아오는 함수
    DateTime tomorrow = DateTime.now().add(Duration(days:1));
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(tomorrow);
  }

  void _showTimeDialog(BuildContext context) { // 예약 시간 팝업창
    final List<int> _items = List.generate(5, (index) => index*2 + 9);
    int result = _items[0];

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(getTomorrow()),
        content: SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 50.0,
            onSelectedItemChanged: (int index) {
              result = _items[index];
            },
            children: _items.map((e) => Center(child: Text('${e}:00-${e+2}:00', textAlign: TextAlign.center,))).toList(),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () {
              // 여기에 Ok 버튼을 눌렀을 때의 동작을 추가하세요.
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
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
                  labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  labelColor: AppColor.Blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3, color: AppColor.Blue),
                  ),
                  tabs: [
                    Tab(text: 'Team Project Room (208관 601호)'),
                  ]
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.forum_rounded, color: AppColor.Blue4, size: 40),
                  const SizedBox( width: 20),
                  DropdownButton(
                    value: _selectedRoom,
                    items: _rooms
                        .map((e)=> DropdownMenuItem(value:e, child: Text(e))).toList(),
                    onChanged: (value){
                      setState(() {
                        _selectedRoom = value!;
                      });
                    },
                  ),
                ],
              ),

             SizedBox(height: 30,),

             SingleChildScrollView(
                scrollDirection:Axis.horizontal,
                child: SingleChildScrollView(
                 child: Container(
                     margin: EdgeInsets.all(16.0),
                     decoration: BoxDecoration(
                       border: Border.all(
                         width: 1,
                         color: AppColor.Grey1,
                       ),
                     ),

                     child: DataTable(columns: const [
                       DataColumn(label: Text('날짜')),
                       DataColumn(label: Text('시간'), numeric: true),
                       DataColumn(label: Text('예약자명')),
                       //DataColumn(label: Text('인원수')),
                       //DataColumn(label: Text('이용목적')),
                     ], rows:  [                   // 예약 현황 표 예시
                       DataRow(cells: [
                         DataCell(Text(getTomorrow())),
                         DataCell(Text('09:00-11:00')),
                         DataCell(Text('김푸앙')),
                         //DataCell(Text('5')),
                         //DataCell(Text('팀플')),
                       ]),
                       DataRow(cells: [
                         DataCell(Text(getTomorrow())),
                         DataCell(Text('13:00-15:00')),
                         DataCell(Text('이푸앙')),
                         //DataCell(Text('3')),
                         //DataCell(Text('캡스톤')),
                       ]),
                     ]),
                 ),
               ),
             ),

             const SizedBox(height: 20,),

             ElevatedButton(onPressed: () {_showTimeDialog(context);},
                 style: ElevatedButton.styleFrom(
                 backgroundColor: AppColor.Blue,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0),
                 )
             ),
                 child: const Text('Reserve',style: TextStyle(fontSize:20),),
             ),
            ],
          ),
        )
    );
  }

  /* 이 아래는 예약 가능 여부 팝업창인데 나중에 백엔드랑 연동 후에 필요할 것 같아서 그대로 둘게요!*/

  void _showAvailableDialog(BuildContext context, int equipmentNum) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
              child: Text(
                'Room #$equipmentNum',
                style: const TextStyle(fontSize: 30, color: AppColor.Blue, fontWeight: FontWeight.bold),
              )
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('현재 사용 가능한 팀플룸입니다.'),
              const Text('홈페이지에서 예약 후 사용할 수 있습니다.'),
              const SizedBox(height: 10),
              const Text(
                'This room is available to reserve now.',
                style: TextStyle(fontSize: 14.4),
              ),
              const Text(
                'You can make a reservation on the website.',
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
                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
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

  void _showUnavailableDialog(BuildContext context, int equipmentNum) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
              child: Text(
                'Room #$equipmentNum',
                style: const TextStyle(fontSize: 30, color: AppColor.Blue, fontWeight: FontWeight.bold),
              )
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('현재 사용 중인 팀플룸입니다.'),
              const Text(
                'This room is not available to reserve now.',
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
                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
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

