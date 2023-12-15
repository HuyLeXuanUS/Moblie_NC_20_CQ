import 'package:flutter/material.dart';
import 'package:final_project/ui/auth/login.dart';
import 'package:final_project/ui/list_teacher/list_teacher.dart';
import 'package:final_project/ui/list_schedule/list_schedule.dart';
import 'package:final_project/ui/list_courses/list_course.dart';
import 'package:final_project/ui/list_history/list_history.dart';
import 'package:final_project/ui/account/account.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // Chỉ số của mục đang được chọn

  final List<Widget> _pages = [
    const ListTeacherPage(),
    const SchedulePage(),
    const HistoryPage(),
    const ListCoursePage(),
    const ListTeacherPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Hiển thị trang tương ứng với mục đã chọn
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
