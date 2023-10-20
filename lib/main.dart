import 'package:flutter/material.dart';
import 'package:final_project/ui/auth/login.dart';
import 'package:final_project/ui/list_teacher/list_teacher.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    LoginPage(),
    ListTeacherPage(),
    LoginPage(),
    ListTeacherPage(),
    LoginPage(),
    ListTeacherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Hiển thị trang tương ứng với mục đã chọn
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tìm kiếm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
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

// Màn hình chuyển hướng body của scarffold
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomeState createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHomePage> {
//   Widget _currentBody = ListTeacherPage();

//   String activeButton = '';
//   String activingButton = 'GIA SƯ';

//   String selectedLanguage = 'Tiếng Việt';
  
//   void _navigateToListTeacherPage() {
//     setState(() {
//       _currentBody = ListTeacherPage();
//     });
//   }

//   void _navigateToTeacherDescriptionPage() {
//     setState(() {
//       _currentBody = TeacherDescriptionPage();
//     });
//   }

//   // Set button đang hoạt động
//   void setActiveButton(String button) {
//     setState(() {
//       activeButton = button;
//     });
//   }

//   void resetButtonsColor() {
//     setState(() {
//       activeButton = '';
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _navigateToListTeacherPage(); // Đặt trạng thái ban đầu của body
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white, // Đặt màu nền thành màu trắng
//         elevation: 6.0, // Đặt độ sâu của hiệu ứng đổ bóng
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Image.asset('assets/picture/icon_lettutor.png',
//                   width: 50,
//                 ),
//                 Text('LetTutor', style: TextStyle(
//                   fontSize: 28,
//                   color: Color.fromARGB(255, 3, 117, 210),
//                   fontFamily: 'MyFont',
//                 )),
//                 SizedBox(width: 15),
//                 Baseline(
//                   baseline: 28.0, // Căn dựa trên baseline của chữ "LetTutor"
//                   baselineType: TextBaseline.alphabetic,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       _buildAppBarButton('GIA SƯ'),
//                       SizedBox(width: 20),
//                       _buildAppBarButton('LỊCH HỌC'),
//                       SizedBox(width: 20),
//                       _buildAppBarButton('LỊCH SỬ'),
//                       SizedBox(width: 20),
//                       _buildAppBarButton('KHÓA HỌC'),
//                       SizedBox(width: 20),
//                       _buildAppBarButton('KHÓA HỌC CỦA TÔI'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),         
//             Spacer(),
//             Row(
//               children: [
//                 PopupMenuButton<String>(
//                   // Popup Menu Button bên phải
//                   onSelected: (value) {
//                     _handleLanguageSelection(value);
//                   },
//                   icon: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: const Color.fromARGB(255, 224, 216, 216), // Màu nền xám
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Image.asset(
//                         'assets/picture/vie_flag_icon.png', // Đường dẫn lá cờ
//                         width: 48,
//                       ),
//                     ),
//                   ),
//                   itemBuilder: (BuildContext context) {
//                     return <PopupMenuEntry<String>>[
//                       PopupMenuItem<String>(
//                         value: 'Tiếng Việt',
//                         child: Text('Tiếng Việt'),
//                       ),
//                       PopupMenuItem<String>(
//                         value: 'Tiếng Anh',
//                         child: Text('Tiếng Anh'),
//                       ),
//                     ];
//                   },
//                   offset: Offset(-10, 30), // Đặt offset để hiển thị menu dưới icon
//                 ),
//                 PopupMenuButton<String>(
//                   // Popup Menu Button bên phải (phía sau)
//                   onSelected: (value) {
//                     // Xử lý sự kiện khi một mục được chọn
//                   },
//                   icon: Icon(
//                     Icons.more_vert, // Icon cho menu bổ sung
//                     color: Colors.black,
//                   ),
//                   itemBuilder: (BuildContext context) {
//                     return <PopupMenuEntry<String>>[
//                       PopupMenuItem<String>(
//                         value: 'Hồ sơ',
//                         child: Text('Hồ sơ'),
//                       ),
//                       PopupMenuItem<String>(
//                         value: 'Ví của tôi',
//                         child: Text('Ví của tôi'),
//                       ),
//                       PopupMenuItem<String>(
//                         value: 'Lịch học định kì',
//                         child: Text('Lịch học định kì'),
//                       ),
//                       PopupMenuItem<String>(
//                         value: 'Đăng xuất',
//                         child: Text('Đăng xuất'),
//                       ),
//                     ];
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: _currentBody,
//     );
//   }

//   void _handleLanguageSelection(String value) {
//     setState(() {
//       selectedLanguage = value;
//     });
//   }

//   Widget _buildAppBarButton(String text) {
//     bool isActive = (text == activeButton) || (text == activingButton);

//     return GestureDetector(
//       onTap: () {
//         setActiveButton(text);
//         if(text == 'GIA SƯ'){
//           activingButton = 'GIA SƯ';
//           _navigateToListTeacherPage();
//         }
//         if(text == 'LỊCH HỌC'){
//           activingButton = 'LỊCH HỌC';
//           _navigateToTeacherDescriptionPage();
//         }
//       },
//       child: MouseRegion(
//         onEnter: (event) {
//           setActiveButton(text);
//         },
//         onExit: (event) {
//           resetButtonsColor();
//         },
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 18,
//             color: isActive ? Color.fromARGB(255, 3, 117, 210) : Colors.grey,
//             fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Màn hình chi tiết giáo viên
class TeacherDescriptionPage extends StatefulWidget{
  @override
  _TeacherDescriptionState createState() => _TeacherDescriptionState();
}

class _TeacherDescriptionState extends State<TeacherDescriptionPage>{
  String activeButton = '';

  String selectedLanguage = 'English';

  void setActiveButton(String button) {
    setState(() {
      activeButton = button;
    });
  }

  void resetButtonsColor() {
    setState(() {
      activeButton = '';
    });
  }

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
                Image.asset('assets/picture/icon_lettutor.png',
                  width: 50,
                ),
                Text('LetTutor', style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
                )),
                SizedBox(width: 15),
                Baseline(
                  baseline: 28.0, // Căn dựa trên baseline của chữ "LetTutor"
                  baselineType: TextBaseline.alphabetic,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildAppBarButton('GIA SƯ'),
                      SizedBox(width: 20),
                      _buildAppBarButton('LỊCH HỌC'),
                      SizedBox(width: 20),
                      _buildAppBarButton('LỊCH SỬ'),
                      SizedBox(width: 20),
                      _buildAppBarButton('KHÓA HỌC'),
                      SizedBox(width: 20),
                      _buildAppBarButton('KHÓA HỌC CỦA TÔI'),
                    ],
                  ),
                ),
              ],
            ),         
            Spacer(),
            Row(
              children: [
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
                        value: 'Tiếng Việt',
                        child: Text('Tiếng Việt'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Tiếng Anh',
                        child: Text('Tiếng Anh'),
                      ),
                    ];
                  },
                  offset: Offset(-10, 30), // Đặt offset để hiển thị menu dưới icon
                ),
                PopupMenuButton<String>(
                  // Popup Menu Button bên phải (phía sau)
                  onSelected: (value) {
                    // Xử lý sự kiện khi một mục được chọn
                  },
                  icon: Icon(
                    Icons.more_vert, // Icon cho menu bổ sung
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Hồ sơ',
                        child: Text('Hồ sơ'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Ví của tôi',
                        child: Text('Ví của tôi'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Lịch học định kì',
                        child: Text('Lịch học định kì'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Đăng xuất',
                        child: Text('Đăng xuất'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // Đặt màu nền thành màu trắng
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(25.0), // Điều chỉnh lề cho Container
                color: Color.fromARGB(255, 10, 13, 189),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa cả 3 hàng
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Buổi học sắp diễn ra',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'T6, 20 Thg 10 23 00:30 - 00:55',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          child: Text('Nút'),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Tổng số giờ bạn đã học là 507 giờ 5 phút',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Hàng 1'), // Hàng 1: Text

                    // Hàng 2: Hai TextField và DropdownButton
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Tên gia sư',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0), // Khoảng cách giữa các phần tử
                        Expanded(
                          child: DropdownButton<String>(
                            value: 'Gia sư nước ngoài',
                            onChanged: (String? newValue) {
                              // Xử lý khi giá trị được thay đổi
                            },
                            items: <String>[
                              'Gia sư nước ngoài',
                              'Gia sư Việt Nam',
                              'Gia sư tiếng Anh bản ngữ',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    Text('Hàng 3'), // Hàng 3: Text

                    // Hàng 4: Hai TextField và DropdownButton
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Ngày',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Giờ bắt đầu',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Giờ kết thúc',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Hàng 5: 12 button lọc
                    Wrap(
                      spacing: 8.0, // Khoảng cách giữa các button
                      children: List.generate(12, (index) {
                        return ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          child: Text('Lọc $index'),
                        );
                      }),
                    ),

                    // Hàng 6: Nút đặt lại bộ tìm kiếm
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          child: Text('Đặt lại bộ tìm kiếm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey, // Màu xám
                thickness: 1.0, // Độ dày của đường kẻ
              ),
              Container(
                
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.black), // Viền trên
                    bottom: BorderSide(width: 1.0, color: Colors.black), // Viền dưới
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0), // Điều chỉnh khoảng cách trên và dưới
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text("Chính sách", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Điều khoản", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Liên hệ", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Hướng dẫn", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Đăng ký làm gia sư", style: TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      ],
                    ),
                    Text("© 2021 - Bản quyền của LetTutor. Tất cả các quyền được bảo lưu.", style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 222, 220, 220),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Công ty TNHH LetTutor Việt Nam  (',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          'MST',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          ': 0317003289',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          ')',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Trụ sở chính: ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '9 Đường Số 3, KDC Cityland Park Hills, Phường 10, Quận Gò Vấp, Thành phố Hồ Chí Minh.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Điện thoại: ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          '0945 337 337',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                        Text(
                          ' Email: ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          'hello@lettutor.com',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  void _handleLanguageSelection(String value) {
    setState(() {
      selectedLanguage = value;
    });
  }

  Widget _buildAppBarButton(String text) {
    bool isActive = text == activeButton;

    return GestureDetector(
      onTap: () {
        setActiveButton(text);
      },
      child: MouseRegion(
        onEnter: (event) {
          setActiveButton(text);
        },
        onExit: (event) {
          resetButtonsColor();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: isActive ? Color.fromARGB(255, 3, 117, 210) : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// Màn hình lịch đã đặt


// Màn hình lịch sử có nhận xét của giáo viên

// Màn hình danh sách khóa học