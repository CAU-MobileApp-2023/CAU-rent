import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamproject/model/RoomRentalData.dart';
import 'package:teamproject/provider/User.dart';
import 'package:teamproject/style.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  //late Map<int, bool> projectRoomRentalStatus;
  //final projectRooms = List.generate(5, (i) => i + 1);

  final _rooms =['-- 선택해 주세요 --', '팀프로젝트실1', '팀프로젝트실2', '팀프로젝트실3', '팀프로젝트실4', '팀프로젝트실5'];
  String? _selectedRoom;
  String tomorrowDate = DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)));

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedRoom = _rooms[0];
    });
    // 각 팀플룸 대여 상태 저장
    // projectRoomRentalStatus = { for (var item in projectRooms) item : item % 2 == 0 };
  }



  late List<dynamic> rentalRecords;

  Future<void> _getRentalRecords() async {
    var result = await http.get(
      Uri.parse('http://10.0.2.2:8000/rental_records/classroom/208관/$_selectedRoom/')
    );
    if (result.statusCode == 200) {
      rentalRecords = jsonDecode(result.body);

      for (var data in rentalRecords) {
        var result = await http.get(
            Uri.parse('http://10.0.2.2:8000/users/inform/${data['renter']}/')
        );
        if (result.statusCode == 200) {
          var responseData = jsonDecode(result.body);
          data['renter'] = responseData['name'];
        }

      }
    }
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
              const SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people, color: AppColor.Blue4, size: 35),
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

              const SizedBox(height: 10),



              _selectedRoom == _rooms[0]
              ? Text('선택하시오')
              : FutureBuilder<void>(
                future: _getRentalRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 180),
                        CircularProgressIndicator()
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColor.Grey1,
                            ),
                          ),



                          child:
                            rentalRecords.isEmpty
                            ? Column(
                              children: [
                                Table(
                                  // border: TableBorder.all(), // 필요에 따라 테두리 설정
                                  // columnWidths: const {
                                  //   0: FixedColumnWidth(100), // 첫 번째 열의 폭 설정
                                  //   1: FixedColumnWidth(100), // 두 번째 열의 폭 설정
                                  //   2: FixedColumnWidth(100), // 세 번째 열의 폭 설정
                                  // },
                                  children: const [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(child: Text('날짜')),
                                        ),
                                        TableCell(
                                          child: Center(child: Text('시간')),
                                        ),
                                        TableCell(
                                          child: Center(child: Text('예약자명')),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Table(
                                  // border: TableBorder.all(), // 필요에 따라 테두리 설정
                                  // columnWidths: const {
                                  //   0: FixedColumnWidth(100), // 첫 번째 열의 폭 설정
                                  //   1: FixedColumnWidth(100), // 두 번째 열의 폭 설정
                                  //   2: FixedColumnWidth(100), // 세 번째 열의 폭 설정
                                  // },
                                  children: const [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(child: Text('예약 정보가 없습니다.')),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : DataTable(
                              columns: const [
                                DataColumn(label: Text('날짜')),
                                DataColumn(label: Text('시간')),
                                DataColumn(label: Text('예약자')),
                              ],

                              rows: rentalRecords.where((data) {
                                return data['start_date'].toString().substring(0, 10) == tomorrowDate;
                              }).map((data) {

                                return DataRow(cells: [
                                  // DataCell(Text(tomorrowDate)),
                                  DataCell(Text('${data['start_date'].toString().substring(0, 10)}')),
                                  DataCell(
                                      Text('${data['start_date'].toString().substring(11, 16)} - ${data['end_date'].toString().substring(11, 16)}')
                                  ),
                                  DataCell(Text(data['renter'])),
                                ]);

                              }).toList(),
                            ),


                        ),



                        const SizedBox(height: 15),


                        ElevatedButton(
                          onPressed: () {
                            _showTimeDialog(context, _selectedRoom!);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.Blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),

                          child: const Text('Reserve', style: TextStyle(fontSize: 20)),
                        ),


                      ],
                    );
                  }
                },
              ),


            ],
          ),
        )
    );
  }



  void _showTimeDialog(BuildContext context, String room) { // 예약 시간 팝업창
    final List<int> _time = List.generate(5, (index) => index * 2 + 9);
    int _selectedTime = _time[0];

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(room, style: const TextStyle(fontSize: 18)),

        content: SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 50.0,
            onSelectedItemChanged: (int index) {
              _selectedTime = _time[index];
            },
            children: _time.map((e) => Center(child: Text('${e}:00-${e+2}:00', textAlign: TextAlign.center,))).toList(),
          ),
        ),

        actions: <Widget>[

          CupertinoDialogAction(
            child: Text('Select'),
            onPressed: () async {
              // 여기에 Ok 버튼을 눌렀을 때의 동작을 추가하세요.


              String renter = context.read<UserProvider>().userStudentId;
              int? roomId;

              var result = await http.get(
                  Uri.parse('http://10.0.2.2:8000/classrooms/inform/208관/$room/')
              );
              if (result.statusCode == 200) {
                Map<String, dynamic> responseData = jsonDecode(result.body);
                roomId = int.parse(responseData['id'].toString());
              }

              String startDate = '${tomorrowDate}T$_selectedTime:00';
              String endDate = '${tomorrowDate}T${_selectedTime+2}:00';

              result = await http.post(
                  Uri.parse('http://10.0.2.2:8000/rental_records/rent/classroom/'),
                  body: jsonEncode(
                      RoomRentalData(renter, roomId, startDate, endDate).toJson()
                  ),
                  headers: {'content-type': 'application/json'}
              );


              Navigator.of(context).pop();
            },
          ),

          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ],
      ),
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


  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }



}

