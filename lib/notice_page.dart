import 'package:flutter/material.dart';
import 'package:teamproject/style.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final List<String> koreanNotices = [
    "중앙대학교 소프트웨어학부 장비 대여 사업 공지",
    "■ 장비 대여 대상: 소프트웨어학부, 컴퓨터공학부 재학생 (대학원생도 가능)",
    "■ 장비 대여 품목",
    "   a. 웹캠, Logitech C992 Pro",
    "   b. LG그램(2021), 16TD90P-GX7DK",
    "   c. M1맥북에어(2020), A2337",
    "■ 장비 대여 장소: 208관 317호",
    "■ 방문 가능 시간: 오전 11시 ~ 오후 6시 (주말 및 공휴일 제외)",
    "■ 장비 대여 및 반납 방법",
    "   (1) cse.cau.ac.kr 접속 -> 열린광장 클릭 -> 장비대여 탭에서 장비 신청",
    "   ( https://cse.cau.ac.kr/sub05/sub0505_cal.php )",
    "   (2) 장비 대여 탭에서 장비 신청 후 대여 전 (최소 2시간 전) 오픈 채팅",
    "   (https://open.kakao.com/o/sXxaAXDd)을 통하여 방문 신청",
    "   ( 내용 : 이름 / 학번 / 장비 번호 / 방문 시간 / 대여 기간 )",
    "   (3) 장비 대여 시에 장비 대장 작성 (학생증 지참, 물품 번호, 대여 전 물품 확인 필수)",
    "   (4) 사용 후 반납 시에도 오픈 채팅 (https://open.kakao.com/o/sXxaAXDd)을 통하여 반납",
    "   시간 신청",
    "   ( 반납 신청도 대여 신청과 동일하게 대여 전 오픈 채팅을 통해 시간 신청 )",
    "   (5) 반납 시에 대여 대장 작성 (반납 시 학생증 지참, 물품 확인 필수)",
    "■ 기타 문의 사항: https://open.kakao.com/o/sXxaAXDd 을 통해 문의",
    "■ 주의사항",
    "   (1) 파손 및 분실 시 배상 책임 부과",
    "   (2) 오픈 채팅 방 참가 시, 성명/학번으로 프로필 고정 필수",
    "■ 기타 사항",
    "   (1) 1회 최대 대여 기간 6개월 가능",
    "   (2) 기간 종료 후 7일내 반납 필수",
  ];

  final List<String> englishNotices = [
    "Chung-Ang University Software Department Equipment Rental Announcement",
    "■ Equipment Rental Eligibility: Students of the Software Department and Computer Engineering Department (Graduate students also eligible)",
    "■ Equipment for Rental",
    "   a. Webcam, Logitech C992 Pro",
    "   b. LG Gram (2021), 16TD90P-GX7DK",
    "   c. M1 MacBook Air (2020), A2337",
    "■ Equipment Rental Location: Building 208, Room 317",
    "■ Visiting Hours: 11 AM - 6 PM (Excluding weekends and public holidays)",
    "■ Equipment Rental and Return Process",
    "   (1) Visit cse.cau.ac.kr -> Click on Open Plaza -> Apply for equipment in the Equipment Rental tab",
    "   ( https://cse.cau.ac.kr/sub05/sub0505_cal.php )",
    "   (2) After applying for equipment in the Equipment Rental tab, apply for a visit at least 2 hours before rental through Open Chat",
    "   (https://open.kakao.com/o/sXxaAXDd)",
    "   ( Details: Name / Student ID / Equipment Number / Visit Time / Rental Period )",
    "   (3) Fill out the equipment log when renting (Student ID required, check equipment number and condition before renting)",
    "   (4) Apply for return time through Open Chat (https://open.kakao.com/o/sXxaAXDd) after use",
    "   ( Return application process is the same as the rental application, apply for time via Open Chat )",
    "   (5) Fill out the rental log upon return (Student ID required, check equipment upon return)",
    "■ Other Inquiries: Via https://open.kakao.com/o/sXxaAXDd",
    "■ Cautions",
    "   (1) Compensation required for damage or loss",
    "   (2) Mandatory to fix profile to Name/Student ID when joining the Open Chat room",
    "■ Additional Information",
    "   (1) Maximum rental period per instance is 6 months",
    "   (2) Return mandatory within 7 days after the end of the rental period",
  ];

  // 스타일 정의
  final TextStyle subTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
  final TextStyle detailTextStyle = TextStyle(fontSize: 14, color: Colors.grey[600]);
  final TextStyle headlineStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.Blue);

  // 소제목과 세부 내용을 묶어서 컨테이너를 만드는 함수
  Widget buildNoticeGroup(List<String> notices) {
    List<Widget> groupWidgets = [];
    bool isHeadlineGroup = false;

    for (var notice in notices) {
      bool isHeadline = notice.contains("중앙대학교 소프트웨어학부 장비 대여 사업 공지") || notice.contains("Chung-Ang University Software Department Equipment Rental Announcement");
      if (isHeadline) {
        isHeadlineGroup = true;
      }
      bool isSubTitle = notice.startsWith('■');

      groupWidgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              notice,
              style: isHeadline ? headlineStyle : isSubTitle ? subTitleStyle : detailTextStyle,
              textAlign: isHeadline ? TextAlign.center : TextAlign.left,
            ),
          )
      );
    }

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isHeadlineGroup ? [] : [
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
      if (notice.startsWith('■')) {
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
                    padding: EdgeInsets.all(10),
                    children: groupNotices(koreanNotices),
                  ),
                  // English 탭의 내용
                  ListView(
                    padding: EdgeInsets.all(10),
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