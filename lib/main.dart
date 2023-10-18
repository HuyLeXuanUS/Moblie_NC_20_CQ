import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterLoginPage(),
    );
  }
}

// Màn hình đăng kí đăng nhập
class RegisterLoginPage extends StatefulWidget {
  @override
  _RegisterLoginState createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLoginPage> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Đặt màu nền thành màu trắng
        elevation: 6.0, // Đặt độ sâu của hiệu ứng đổ bóng
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'assets/picture/icon_lettutor.png', // Icon của app
                  width: 50, // Đặt kích thước của ảnh
                ),
                Text('LetTutor', style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontWeight: FontWeight.bold,
                )),
              ],
            ),
            PopupMenuButton<String>(
              // Popup Menu Button bên phải
              onSelected: (value) {
                _handleLanguageSelection(value);
              },
              icon: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 224, 216, 216), // Màu nền xám
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    'assets/picture/vie_flag_icon.png', // Đường dẫn lá cờ
                    width: 48,
                  ),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'English',
                    child: Text('English'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Tiếng Việt',
                    child: Text('Tiếng Việt'),
                  ),
                ];
              },
              offset: Offset(-10, 30), // Đặt offset để hiển thị menu dưới icon
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }

  void _handleLanguageSelection(String value) {
    setState(() {
      selectedLanguage = value;
    });
  }
}