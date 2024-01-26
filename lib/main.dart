import 'package:final_project/services/envs/enviroment.dart';
import 'package:final_project/services/share_local/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:final_project/ui/auth/login.dart';
import 'package:final_project/ui/list_teacher/list_teacher.dart';
import 'package:final_project/ui/list_schedule/list_schedule.dart';
import 'package:final_project/ui/list_courses/list_course.dart';
import 'package:final_project/ui/list_history/list_history.dart';
import 'package:final_project/ui/account/account.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


void main() {
  // ignore: unused_local_variable, prefer_const_constructors
  final flavor = String.fromEnvironment('FLAVOR');

  if (flavor == 'dev') {
    // ignore: unused_local_variable
    Enviroments.setEnviroment(Enviroment.DEV);
  } else if (flavor == 'product') {
    // ignore: unused_local_variable
    Enviroments.setEnviroment(Enviroment.PROD);
  } else {
    // ignore: unused_local_variable
    Enviroments.setEnviroment(Enviroment.DEV);
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: MyApp(),
    ),
  );
}

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
      supportedLocales: [
        Locale('vi', ''),
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
  int _currentIndex = 0;
  // ignore: prefr_final_fields

  List<Widget> get _pages => [
    const ListTeacherPage(),
    const SchedulePage(),
    const HistoryPage(),
    const ListCoursePage(),
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
            label: 'Tutor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
