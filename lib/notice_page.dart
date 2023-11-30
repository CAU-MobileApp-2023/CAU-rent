import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final List<String> koreanNotices = [
    "공지사항 1",
    "공지사항 2",
    "공지사항 3",
  ];

  final List<String> englishNotices = [
    "Notice 1",
    "Notice 2",
    "Notice 3",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              "Notice",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TabBar(
                labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                labelColor: AppColor.Blue,
                unselectedLabelColor: AppColor.Blue2,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: AppColor.Blue),
                ),
                tabs: [
                  Tab(text: '한국어'),
                  Tab(text: 'English'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 한국어 탭의 내용
                  ListView.builder(
                    itemCount: koreanNotices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Center(
                          child: Text(koreanNotices[index],
                          textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  // English 탭의 내용
                  ListView.builder(
                    itemCount: englishNotices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Center (
                          child: Text(englishNotices[index],
                          textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
