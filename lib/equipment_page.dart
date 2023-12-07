import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamproject/model/EquipmentRentalData.dart';
import 'package:teamproject/provider/User.dart';
import 'package:teamproject/style.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'http://caurent.kro.kr:8000';


class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final equipment = ['MacBook', 'LG gram', 'WebCam'];

  late Map<int, bool> macBookAvailability;
  late Map<int, bool> lgGramAvailability;
  late Map<int, bool> webCamAvailability;

  final macBooks = List.generate(27, (i) => i + 1);
  final lgGrams = List.generate(22, (i) => i + 1);
  final webCams = List.generate(19, (i) => i + 1);


  @override
  void initState() {
    super.initState();
    macBookAvailability = { for (var item in macBooks) item : true };
    lgGramAvailability = { for (var item in lgGrams) item : true };
    webCamAvailability = { for (var item in webCams) item : true };
  }

  Future<void> _setRentalStatus() async {
    for (var i in macBooks) {
      var result = await http.get(
          Uri.parse('$baseUrl/devices/availability/${equipment[0]}/$i/')
      );
      if (result.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(result.body);
        macBookAvailability[i] = responseData[0]['is_available'];
      }
    }

    for (var i in lgGrams) {
      var result = await http.get(
          Uri.parse('$baseUrl/devices/availability/${equipment[1]}/$i/')
      );
      if (result.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(result.body);
        lgGramAvailability[i] = responseData[0]['is_available'];
      }
    }

    for (var i in webCams) {
      var result = await http.get(
          Uri.parse('$baseUrl/devices/availability/${equipment[2]}/$i/')
      );
      if (result.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(result.body);
        webCamAvailability[i] = responseData[0]['is_available'];
      }
    }
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TabBar(
                    labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    labelColor: AppColor.Blue,
                    unselectedLabelColor: AppColor.Blue2,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3, color: AppColor.Blue),
                    ),
                    tabs: [
                      Tab(text: equipment[0]),
                      Tab(text: equipment[1]),
                      Tab(text: equipment[2]),
                    ]
                ),
              ),


              FutureBuilder<void>(
                future: _setRentalStatus(),
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
                    return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TabBarView(
                            children: [
                              GridView.count(
                                crossAxisCount: 4,
                                children: macBooks.map((i) => Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (macBookAvailability[i] == true) {
                                          _showDatePickerDialog(context, equipment[0], i);



                                        } else {
                                          _showUnavailableDialog(context, equipment[0], i);
                                        }
                                      },
                                      icon: macBookAvailability[i] == true
                                          ? const Icon(Icons.laptop_mac, color: AppColor.Blue4)
                                          : const Icon(Icons.laptop_mac, color: AppColor.Grey1),
                                      iconSize: 65,
                                      padding: EdgeInsets.zero,
                                    ),
                                    Text(
                                        "#$i",
                                        style: macBookAvailability[i] == true
                                            ? const TextStyle(fontSize: 16, color: AppColor.Blue4, fontWeight: FontWeight.bold)
                                            : const TextStyle(fontSize: 16, color: AppColor.Grey1, fontWeight: FontWeight.bold)
                                    ),
                                  ],
                                )).toList(),
                              ),

                              GridView.count(
                                crossAxisCount: 4,
                                children: lgGrams.map((i) => Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (lgGramAvailability[i] == true) {
                                          _showDatePickerDialog(context, equipment[1], i);


                                        } else {
                                          _showUnavailableDialog(context, equipment[1], i);
                                        }
                                      },
                                      icon: lgGramAvailability[i] == true
                                          ? const Icon(Icons.laptop_windows, color: AppColor.Blue4)
                                          : const Icon(Icons.laptop_windows, color: AppColor.Grey1),
                                      iconSize: 65,
                                      padding: EdgeInsets.zero,
                                    ),
                                    Text(
                                        "#$i",
                                        style: lgGramAvailability[i] == true
                                            ? const TextStyle(fontSize: 16, color: AppColor.Blue4, fontWeight: FontWeight.bold)
                                            : const TextStyle(fontSize: 16, color: AppColor.Grey1, fontWeight: FontWeight.bold)
                                    ),
                                  ],
                                )).toList(),
                              ),

                              GridView.count(
                                crossAxisCount: 4,
                                children: webCams.map((i) => Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (webCamAvailability[i] == true) {
                                          _showDatePickerDialog(context, equipment[2], i);


                                        } else {
                                          _showUnavailableDialog(context, equipment[2], i);
                                        }
                                      },
                                      icon: webCamAvailability[i] == true
                                          ? const Icon(Icons.photo_camera, color: AppColor.Blue4)
                                          : const Icon(Icons.photo_camera, color: AppColor.Grey1),
                                      iconSize: 65,
                                      padding: EdgeInsets.zero,
                                    ),
                                    Text(
                                        "#$i",
                                        style: webCamAvailability[i] == true
                                            ? const TextStyle(fontSize: 16, color: AppColor.Blue4, fontWeight: FontWeight.bold)
                                            : const TextStyle(fontSize: 16, color: AppColor.Grey1, fontWeight: FontWeight.bold)
                                    ),
                                  ],
                                )).toList(),
                              ),
                            ],
                          ),
                        )
                    );
                  }
                },
              ),

            ],
          ),
        )
    );
  }







  void _showModalBottomSheet(BuildContext context, String equipmentType, int equipmentNum, DateTimeRange? rentalPeriod) {
    String? startDate = rentalPeriod?.start.toLocal().toString().split(' ')[0];
    String? endDate = rentalPeriod?.end.toLocal().toString().split(' ')[0];


    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 450,
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



                  Container(
                    width: 340,
                    height: 150,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        const Text(
                            'Rental Period',
                            style: TextStyle(fontSize: 20, color: AppColor.Blue4, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 8),

                        // 선택된 날짜 범위 표시

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${startDate?.split('-').join('.')}. - ${endDate?.split('-').join('.')}.',
                            style: const TextStyle(fontSize: 22, color: AppColor.Blue4, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          '대여 기간 미준수 시 이용이 제한될 수 있습니다.',
                          style: TextStyle(fontSize: 12),
                        ),


                      ],
                    ),
                  ),



                  const SizedBox(height: 20),
                  const Text(
                    '대여하시겠습니까?',
                    style: TextStyle(fontSize: 32, color: AppColor.Blue4, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Do you want to rent?',
                    style: TextStyle(fontSize: 22, color: AppColor.Blue4, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {

                          // 대여 처리 로직
                          String renter = context.read<UserProvider>().userStudentId;
                          int? device;

                          var result = await http.get(
                            Uri.parse('$baseUrl/devices/inform/$equipmentType/$equipmentNum/')
                          );
                          if (result.statusCode == 200) {
                            Map<String, dynamic> responseData = jsonDecode(result.body);
                            device = int.parse(responseData['id'].toString());
                          }

                          result = await http.post(
                            Uri.parse('$baseUrl/rental_records/rent/device/'),
                            body: jsonEncode(
                              EquipmentRentalData(renter, device, startDate, endDate).toJson()
                            ),
                            headers: {'content-type': 'application/json'}
                          );


                          Navigator.of(context).pop();

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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // AlertDialog 닫기
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
                          side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppColor.Blue, width: 2.0)),
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
      },
    );
  }

  void _showDatePickerDialog(BuildContext context, String equipmentType, int equipmentNum) {
    DateTime? selectedStartDate;
    DateTime? selectedEndDate;
    DateTime maxDate = DateTime.now().add(const Duration(days: 90)); // 초기 maxDate 설정

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder( // StatefulBuilder 추가
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Select Date Range'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: SfDateRangePicker(
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is PickerDateRange) {
                        final PickerDateRange range = args.value;
                        selectedStartDate = range.startDate;
                        selectedEndDate = range.endDate ?? range.startDate!.add(const Duration(days: 1));

                        // 시작 날짜가 선택되면 maxDate 업데이트
                        if (selectedStartDate != null) {
                          setState(() {
                            maxDate = selectedStartDate!.add(const Duration(days: 7));
                          });
                        }
                      }
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                    minDate: DateTime.now(),
                    maxDate: maxDate, // 동적으로 변경된 maxDate 사용
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text('Select', style: TextStyle(fontSize: 18)),
                        onPressed: () {

                          DateTimeRange? selectedDateRange;
                          if (selectedStartDate != null && selectedEndDate != null) {
                            Navigator.of(context).pop();
                            selectedDateRange = DateTimeRange(start: selectedStartDate!, end: selectedEndDate!);
                            _showModalBottomSheet(context, equipmentType, equipmentNum, selectedDateRange);
                          }

                        },
                      ),

                      const SizedBox(width: 20),


                      TextButton(
                        child: const Text('Cancel', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),


                    ],
                  ),
                ],
              );
            }
        );
      },
    );
  }



  void _showUnavailableDialog(BuildContext context, String equipmentType, int equipmentNum) {
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // AlertDialog 닫기
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(AppColor.Blue),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(140, 50)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
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