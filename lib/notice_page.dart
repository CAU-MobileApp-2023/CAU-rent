import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final List<String> koreanNotices = [
    "CAU-rent 장비 대여",
    "■  장비 대여 대상",
    "   소프트웨어학부 재학생",
    "■  장비 대여 품목",
    "   a. M1맥북에어(2020), A2337",
    "   b. LG그램(2021), 16TD90P-GX7DK",
    "   c. 웹캠, Logitech C992 Pro",
    "■  장비 대여 및 반납 방법",
    "  1. 장비 대여 탭에서 장비 신청 후 대여 전 오픈 채팅을 통하여 방문 신청",
    "   (https://open.kakao.com/o/sXxaAXDd)",
    "  2. 장비 대여 시 장비 대장 작성 (학생증 지참, 물품 번호 및 물품 상태 확인)",
    "  3. 사용 후 반납 시에도 오픈 채팅을 통하여 반납",
    "  4. 반납 시에 대여 대장 작성 (학생증 지참)",
    "■  장비 대여 장소",
    "   208관 317호",
    "■  주의사항",
    "  • 파손 및 분실 시 배상 책임 부과",
    "  • 대여기간 내 반납 필수",


    "CAU-rent 팀플룸 예약",
    "■  팀플룸 예약 대상",
    "   소프트웨어학부 재학생",
    "■  팀플룸 장소",
    "   208관 6층",
    "■  주의사항",
    "  • 예약된 시간에만 사용 가능",
    "  • 사용 후 뒷정리 필수",
  ];

  final List<String> englishNotices = [
    "CAU-rent Equipment Rental",
    "■  Target",
    "   Students of Software Department",
    "■  Equipment",
    "   a. M1 MacBook Air (2020), A2337",
    "   b. LG Gram (2021), 16TD90P-GX7DK",
    "   c. Webcam, Logitech C992 Pro",
    "■  How to Rent and Return",
    "  1. After applying for equipment in the Equipment Rental tab, apply for a visit through Open Chat",
    "   (https://open.kakao.com/o/sXxaAXDd)",
    "  2. Fill out the equipment log when renting (Student ID required, check equipment number and condition before renting)",
    "  3. Apply for return through Open Chat after use",
    "  4. Fill out the rental log upon return (Student ID required)",
    "■  Location",
    "   Building 208, Room 317",
    "■  Cautions",
    "  • Compensation required for damage or loss",
    "  • Return must be made within the rental period",

    "CAU-rent Room Reservation",
    "■  Target",
    "   Students of Software Department",
    "■  Location",
    "   Building 208, 6th floor",
    "■  Cautions",
    "  • Available only at reserved time",
    "  • Make sure to clean up after using",
  ];

  // 스타일 정의
  final TextStyle subTitleStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  final TextStyle detailTextStyle = TextStyle(fontSize: 14.5, color: Colors.grey[700]);
  final TextStyle headlineStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.Blue);

  // 소제목과 세부 내용을 묶어서 컨테이너를 만드는 함수
  Widget buildNoticeGroup(List<String> notices) {
    List<Widget> groupWidgets = [];
    bool isHeadlineGroup = false;

    for (var notice in notices) {
      bool isHeadline = notice.contains("CAU-rent 장비 대여") || notice.contains("CAU-rent Equipment Rental")
          || notice.contains("CAU-rent 팀플룸 예약") || notice.contains("CAU-rent Room Reservation");
      if (isHeadline) {
        isHeadlineGroup = true;
      }
      bool isSubTitle = notice.startsWith('■');

      groupWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: isHeadline
              ? Center(child: Text(notice, style: headlineStyle,))
              : Text(notice, style: isSubTitle ? subTitleStyle : detailTextStyle),
          )
      );
    }

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: !isHeadlineGroup ? [] : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupWidgets,
      ),
    );
  }

  // 소제목에 따라 공지사항을 그룹화하는 함수
  List<Widget> groupNotices(List<String> notices) {
    List<Widget> groupedWidgets = [];
    List<String> currentGroup = [];

    for (var notice in notices) {
      bool isHeadline = notice.contains("CAU-rent 장비 대여") || notice.contains("CAU-rent Equipment Rental")
          || notice.contains("CAU-rent 팀플룸 예약") || notice.contains("CAU-rent Room Reservation");
      if (notice.startsWith('■') || isHeadline) {
        if (currentGroup.isNotEmpty) {
          groupedWidgets.add(buildNoticeGroup(currentGroup));
          currentGroup = [];
        }
      }
      currentGroup.add(notice);
    }

    if (currentGroup.isNotEmpty) {
      groupedWidgets.add(buildNoticeGroup(currentGroup));
    }

    return groupedWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 70),
            const Text("Notice", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
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
                  ListView(
                    padding: const EdgeInsets.all(10),
                    children: groupNotices(koreanNotices),
                  ),
                  // English 탭의 내용
                  ListView(
                    padding: const EdgeInsets.all(10),
                    children: groupNotices(englishNotices),
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