import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';
import 'package:intl/intl.dart';


class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late Map<int, bool> projectRoomRentalStatus;
  final projectRooms = List.generate(5, (i) => i + 1);

  TimeOfDay startTime = TimeOfDay (hour:0,minute: 0); // 예약 시작 시간
  TimeOfDay endTime = TimeOfDay (hour:0,minute: 0); // 예약 마감 시간

  @override
  void initState() {
    super.initState();
    // 각 팀플룸 대여 상태 저장
    projectRoomRentalStatus = { for (var item in projectRooms) item : item % 2 == 0 };
  }

  String getTomorrow(){ // 예약 날짜(내일)
    DateTime tomorrow = DateTime.now().add(Duration(days:1));
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(tomorrow);
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

              Text(getTomorrow(),style: const TextStyle(fontSize:24,fontWeight: FontWeight.bold),),

              const SizedBox(
                height: 5,
              ),

              Text('${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}',style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

              const SizedBox(height: 10),

              ElevatedButton(onPressed: () async { // 예약 시간 설정
               final TimeOfDay? timeOfDay1 = await showTimePicker(context: context, initialTime: startTime);
               final TimeOfDay? timeOfDay2 = await showTimePicker(context: context, initialTime: endTime);

                if(timeOfDay1 != null || timeOfDay2 != null){
                  if(timeOfDay2!.hour-timeOfDay1!.hour>2 || timeOfDay2.hour-timeOfDay1!.hour<0){ // 예약 시간 설정 오류 시 팝업창
                      _showInvalidTimeIntervalDialog();
                  }
                  else{
                    setState(() {
                      startTime = timeOfDay1!;
                      endTime = timeOfDay2!;
                    });
                    }
                }
              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.Blue4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )
                    ),
                  child: Text('예약 시간')
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: projectRooms.map((i) => TextButton.icon(
                    onPressed: () {
                      if (projectRoomRentalStatus[i] == true) {
                        _showUnavailableDialog(context, i);
                      } else {
                        _showAvailableDialog(context, i);
                      }
                    },
                    icon: projectRoomRentalStatus[i] == true
                        ? const Icon(Icons.forum_rounded, color: AppColor.Grey1, size: 34)
                        : const Icon(Icons.forum_rounded, color: AppColor.Blue4, size: 34),
                    label: Text(
                        "  Team Project Room #$i",
                        style: projectRoomRentalStatus[i] == true
                             ? const TextStyle(fontSize: 24, color: AppColor.Grey1, fontWeight: FontWeight.bold)
                             : const TextStyle(fontSize: 24, color: AppColor.Blue4, fontWeight: FontWeight.bold)
                    ),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
    );
  }

  void _showInvalidTimeIntervalDialog() { // 예약 시간 오류 팝업
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('예약 가능 시간은 최대 2시간 입니다.'),
              const SizedBox( height: 10,),
              const Text(
                'You can make a reservation 2 hours at most',
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

