import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';
import 'package:intl/intl.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  String getDuedate(){ //일단은 오늘 기준으로 한달 뒤를 반납일로 설정함.
    DateTime due = DateTime.now().add(const Duration(days:30));
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(due);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
            children: [
              const SizedBox(height: 70),
              const Text('My Page', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),

              Container(
                width: 320,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2, color: AppColor.Blue)
                ),

                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.Blue),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '000',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.right
                          ),
                        ],
                      ),
                    ),

                    Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Student ID',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.Blue),
                            textAlign: TextAlign.left
                          ),
                          Text(
                            '00000000',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign:TextAlign.right
                          ),
                        ],
                      ),
                    ),

                    Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Phone',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.Blue),
                              textAlign:TextAlign.left
                          ),
                          Text(
                              '010-0000-0000',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.right
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Container(
                height: 1.0,
                width: 300.0,
                color: AppColor.Grey1,
              ),

              const SizedBox(height: 30),

              const Text('Rental Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              const SizedBox(height: 25),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SizedBox(
                      width: 100,
                      child: Column(
                          children:[
                            const Text('MacBook',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16, color: AppColor.Blue),),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 2.0,
                              width: 70.0,
                              color: AppColor.Blue,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Icon(Icons.laptop_mac, color: AppColor.Blue4, size: 65),

                            Text(getDuedate(),style: TextStyle(fontWeight: FontWeight.bold),),

                          ]
                      ),
                    ),

                    SizedBox(
                      width: 100,
                      child: Column(
                          children:[
                            const Text('LG gram',style:TextStyle(fontWeight:FontWeight.bold, fontSize: 16, color: AppColor.Blue),),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 2.0,
                              width: 70.0,
                              color: AppColor.Blue,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Icon(Icons.close_rounded, color: AppColor.Grey1, size: 65),

                            Text('-'),
                          ]
                      ),
                    ),


                    SizedBox(
                      width: 100,
                      child: Column(
                          children:[
                            const Text('WebCam',style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColor.Blue)),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 2.0,
                              width: 70.0,
                              color: AppColor.Blue,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Icon(Icons.close_rounded, color: AppColor.Grey1, size: 65),

                            Text('-'),
                          ]
                      ),
                    ),
                  ]
              ),

              const SizedBox(height: 30),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                  'Log Out',
                  style: TextStyle(fontSize: 14),
                ),
              ),

            ]
        ),
      ),
    );
  }
}