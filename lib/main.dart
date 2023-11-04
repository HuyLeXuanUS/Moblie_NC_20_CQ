import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as htmlParser;
import 'package:final_project/ui/auth/login.dart';
import 'package:final_project/ui/list_teacher/list_teacher.dart';
import 'package:final_project/ui/schedule/schedule.dart';
import 'package:final_project/ui/list_courses/list_course.dart';
import 'package:final_project/ui/history/history.dart';
import 'package:final_project/ui/account/account.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Chỉ số của mục đang được chọn

  final List<Widget> _pages = [
    ListTeacherPage(),
    SchedulePage(),
    HistoryPage(),
    ListCoursePage(),
    ListTeacherPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Hiển thị trang tương ứng với mục đã chọn
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.co_present),
            label: 'Gia sư',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Lịch học',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Khóa học',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_color),
            label: 'Khóa học của tôi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // Hiển thị tất cả các biểu tượng
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
