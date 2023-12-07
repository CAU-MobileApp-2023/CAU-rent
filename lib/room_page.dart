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
  final _rooms =['-- 선택해 주세요 --', '팀프로젝트실1', '팀프로젝트실2', '팀프로젝트실3', '팀프로젝트실4', '팀프로젝트실5'];
  String? _selectedRoom;
  String tomorrowDate = DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)));

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedRoom = _rooms[0];
    });
  }


  late List<dynamic> rentalRecords;

  Future<void> _getRentalRecords() async {
    var result = await http.get(
      Uri.parse('http://caurent.kro.kr:8000/rental_records/classroom/208관/$_selectedRoom/$tomorrowDate')
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
                  const SizedBox(width: 20),
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
              ? SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Table(
                      children: const [
                        TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                  height: 50,
                                  child: Center(child: Text('날짜'))
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 50,
                                  child: Center(child: Text('시간'))
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                  height: 50,
                                  child: Center(child: Text('예약자명'))
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Table(
                      border: const TableBorder(
                        top: BorderSide(width: 1, color: AppColor.Grey1),
                      ),
                      children: const [
                        TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                  height: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('팀프로젝트실을 선택해 주세요.'),
                                      Text('Select the Team Project Room.'),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              )
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

                          child:
                            rentalRecords.isEmpty
                            ? SizedBox(
                              width: 350,
                              child: Column(
                                children: [
                                  Table(
                                    children: const [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Center(child: Text('날짜'))
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Center(child: Text('시간'))
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Center(child: Text('예약자명'))
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Table(
                                    border: const TableBorder(
                                      top: BorderSide(width: 1, color: AppColor.Grey1),
                                    ),
                                    // border: TableBorder.all(width: 1, color: AppColor.Grey1,),
                                    children: const [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 70,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('예약 정보가 없습니다.'),
                                                  Text('There is no reservation.'),
                                                ],
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                                  DataCell(Text(data['start_date'].toString().substring(0, 10))),
                                  DataCell(
                                      Text('${data['start_date'].toString().substring(11, 16)}-${data['end_date'].toString().substring(11, 16)}')
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            fixedSize: MaterialStateProperty.all<Size>(const Size(90, 30)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )
                            ),
                          ),

                          child: const Text(
                              'Reserve',
                              style: TextStyle(fontSize: 14)),
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
        title: Text(room, style: const TextStyle(fontSize: 20)),

        content: SizedBox(
          height: 220,
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
            child: const Text(
              'Select',
              style: TextStyle(color: AppColor.Blue, fontWeight: FontWeight.w500),
            ),
            onPressed: () async {

              String renter = context.read<UserProvider>().userStudentId;
              int? roomId;
              String startDate = '${tomorrowDate}T$_selectedTime:00';
              String endDate = '${tomorrowDate}T${_selectedTime+2}:00';


              bool isReservedTime = true;

              var result = await http.get(
                  Uri.parse('http://10.0.2.2:8000/classrooms/availability/208관/$room/$tomorrowDate/')
              );
              if (result.statusCode == 200) {
                List<dynamic> responseData = jsonDecode(result.body);
                isReservedTime = responseData[_selectedTime - 9]['is_available'];

              }

              Navigator.of(context).pop();

              if (!isReservedTime) {
                _showReservationFailDialog(context);
              }

              else {
                result = await http.get(Uri.parse(
                    'http://10.0.2.2:8000/classrooms/inform/208관/$room/'));
                if (result.statusCode == 200) {
                  Map<String, dynamic> responseData = jsonDecode(result.body);
                  roomId = int.parse(responseData['id'].toString());
                }

                result = await http.post(
                    Uri.parse(
                        'http://10.0.2.2:8000/rental_records/rent/classroom/'),
                    body: jsonEncode(
                        RoomRentalData(renter, roomId, startDate, endDate)
                            .toJson()),
                    headers: {'content-type': 'application/json'});


                _showReservationSuccessDialog(context, tomorrowDate, _selectedTime);
              }
            },
          ),

          CupertinoDialogAction(
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColor.Blue, fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),


        ],
      ),
    );
  }


  void _showReservationSuccessDialog(BuildContext context, String date, int time) {

    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Successfully Reserved', style: TextStyle(fontSize: 22)),

        content: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 18),
              Text('Date: $date', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Time: $time:00 - ${time+2}:00', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),

        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text(
              'Confirm',
              style: TextStyle(color: AppColor.Blue, fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ],


      ),
    );

  }



  void _showReservationFailDialog(BuildContext context) {

    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Failed to Reserve', style: TextStyle(fontSize: 24)),

          content: const SizedBox(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('현재 사용 중인 팀플룸입니다.', style: TextStyle(fontSize: 14)),
                Text(
                  'This room is not available to reserve now.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),


          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                'Confirm',
                style: TextStyle(color: AppColor.Blue, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        ),
    );

  }


}

