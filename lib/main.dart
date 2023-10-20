import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:final_project/ui/auth/login.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

// Màn hình chuyển hướng body của scarffold
class MyHomePage extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  Widget _currentBody = ListTeacherPage();

  String activeButton = '';
  String activingButton = 'GIA SƯ';

  String selectedLanguage = 'Tiếng Việt';
  
  void _navigateToListTeacherPage() {
    setState(() {
      _currentBody = ListTeacherPage();
    });
  }

  void _navigateToTeacherDescriptionPage() {
    setState(() {
      _currentBody = TeacherDescriptionPage();
    });
  }

  // Set button đang hoạt động
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
  void initState() {
    super.initState();
    _navigateToListTeacherPage(); // Đặt trạng thái ban đầu của body
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
      body: _currentBody,
    );
  }

  void _handleLanguageSelection(String value) {
    setState(() {
      selectedLanguage = value;
    });
  }

  Widget _buildAppBarButton(String text) {
    bool isActive = (text == activeButton) || (text == activingButton);

    return GestureDetector(
      onTap: () {
        setActiveButton(text);
        if(text == 'GIA SƯ'){
          activingButton = 'GIA SƯ';
          _navigateToListTeacherPage();
        }
        if(text == 'LỊCH HỌC'){
          activingButton = 'LỊCH HỌC';
          _navigateToTeacherDescriptionPage();
        }
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

// Màn hình danh sách giáo viên
class ListTeacherPage extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacherPage>{
  //final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: EdgeInsets.only(
                top: 30.0, // Padding ở phía trên
                left: 80.0, // Padding ở phía bên trái
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tìm kiếm gia sư',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // In đậm
                      color: Colors.black, // Màu đen
                      fontSize: 30, // Cỡ chữ 30
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[                       
                      Container(
                        width: 300.0,
                        padding: EdgeInsets.only(left: 30), // Padding cho TextField
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0), // Viền
                          borderRadius: BorderRadius.circular(60.0), // Góc bo tròn
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nhập tên gia sư..',
                            border: InputBorder.none, // Loại bỏ viền mặc định
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                        width: 600.0,
                        padding: EdgeInsets.only(left: 30, right: 30), // Padding cho DropdownButton
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0), // Viền
                          borderRadius: BorderRadius.circular(60.0), // Góc bo tròn
                        ),
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
                  SizedBox(height: 16.0),
                  Text(
                    'Chọn thời gian dạy kèm có lịch trống: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // In đậm
                      color: Colors.black, // Màu đen
                      fontSize: 18, // Cỡ chữ 18
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Hàng 4: Hai TextField và DropdownButton
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DateTimeField(
                          selectedDate: DateTime.now(), // Đặt giá trị ngày và giờ mặc định
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0), // Đặt bo tròn
                            ),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Chọn ngày..', // Đổi tên hiển thị
                          ),
                          mode: DateTimeFieldPickerMode.date, // Chọn cả ngày và giờ
                          onDateSelected: (DateTime value) {
                            //print(value.day.toString()+'-'+value.month.toString()+'-'+value.year.toString());
                          },
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
                  SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('Tất cả'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('Tiếng Anh cho trẻ em'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('Tiếng Anh cho công việc'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('Giao tiếp'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('STARTERS'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('MOVERS'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('FLYERS'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('KET'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('PET'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('IELTS'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('TOEFL'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 219, 216, 216), // Đặt màu nền xám
                            onPrimary: Colors.black, // Đặt màu chữ đen
                            elevation: 0, // Loại bỏ độ sâu
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                            ),
                          ),
                          child: Text('TOEIC'),
                        ),
                        // Thêm các button khác tương tự cho các mục tiêu còn lại
                      ],
                    ),
                  ),
                  // Hàng 6: Nút đặt lại bộ tìm kiếm
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nút được nhấn
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 169, 184, 224), // Đặt màu nền xám
                          onPrimary: Colors.black, // Đặt màu chữ đen
                          elevation: 0, // Loại bỏ độ sâu
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Đặt bo tròn
                          ),
                        ),
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
              padding: EdgeInsets.only(top:30.0, left: 80.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                    'Gia sư được đề xuất',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // In đậm
                      color: Colors.black, // Màu đen
                      fontSize: 30, // Cỡ chữ 30
                    ),
                  ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3, // Số lượng hàng bạn muốn hiển thị
                    itemBuilder: (BuildContext context, int index) {
                      // Tạo một dòng gồm 3 View
                      return Row(
                        children: <Widget>[
                          // Đặt View 1 ở đây
                          // Đặt View 2 ở đây
                          // Đặt View 3 ở đây
                        ],
                      );
                    },
                  ),
                ],
              ),
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
    );
  }
}

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