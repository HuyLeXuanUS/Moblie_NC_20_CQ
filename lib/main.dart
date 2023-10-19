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
                  fontFamily: 'MyFont',
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
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // Đặt màu nền thành màu trắng
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.all(80.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 112, 109, 109), // Màu viền
                            width: 1.0, // Độ rộng của viền
                          ),
                          borderRadius: BorderRadius.circular(50.0), // Bo viền với bán kính 10
                        ),
                        // Cột thứ nhất: Khung đăng nhập
                        child: Padding(
                          padding: const EdgeInsets.all(45.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Color.fromARGB(255, 3, 117, 210),
                                    fontFamily: 'MyFont',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 40), // Khoảng cách giữa dòng "Đăng nhập" và mô tả
                              Text(
                                'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'MyFont'
                                ),
                              ),
                              SizedBox(height: 30), // Khoảng cách giữa các dòng
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ĐỊA CHỈ EMAIL',),
                                  SizedBox(height: 5), // Khoảng cách giữa Text và TextField
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'mail@example.com',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('MẬT KHẨU'),
                                  SizedBox(height: 5), // Khoảng cách giữa Text và TextField
                                  TextField(
                                    decoration: InputDecoration(
                                      //hintText: 'Nhập địa chỉ email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    // Xử lí sự kiện quên mật khẩu
                                  },
                                  child: Text('Quên mật khẩu?'),
                                ),
                              ),
                              SizedBox(height: 10), // Khoảng cách giữa các dòng
                              Container(
                                width: double.infinity,
                                height: 40, // Đặt chiều cao của nút // Đặt chiều rộng là toàn màn hình
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0), // Bo tròn góc
                                  color: Color.fromARGB(255, 3, 117, 210), // Màu nền
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Xử lí sự kiện khi nút được nhấn
                                  },
                                  child: Center(
                                    child: Text(
                                      'ĐĂNG NHẬP',
                                      style: TextStyle(
                                        color: Colors.white, // Màu chữ
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text('Hoặc tiếp tục với:',
                                style: TextStyle(
                                    fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center, // Căn chỉnh các biểu tượng giữa
                                children: [
                                  Container(
                                    width: 50, // Điều chỉnh kích thước của vòng tròn
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle, // Hình dạng vòng tròn
                                      border: Border.all(
                                        color: Color.fromARGB(255, 3, 117, 210), // Màu viền
                                        width: 1.0, // Độ rộng của viền
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.facebook, // Biểu tượng của Facebook
                                      color: Color.fromARGB(255, 3, 117, 210), // Màu biểu tượng
                                      size: 40, // Điều chỉnh kích thước của biểu tượng
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    width: 50, // Điều chỉnh kích thước của vòng tròn
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle, // Hình dạng vòng tròn
                                      border: Border.all(
                                        color: Colors.blue, // Màu viền
                                        width: 1.0, // Độ rộng của viền
                                      ),
                                      color: Colors.white, // Màu nền
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0), // Điều chỉnh khoảng cách giữa biểu tượng và vòng tròn
                                      child: Image.asset(
                                        'assets/picture/icon_google.png', // Thay đường dẫn bằng tên tệp PNG của biểu tượng
                                        width: 40, // Điều chỉnh kích thước của biểu tượng
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    width: 50, // Điều chỉnh kích thước của vòng tròn
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle, // Hình dạng vòng tròn
                                      border: Border.all(
                                        color: Color.fromARGB(255, 3, 117, 210), // Màu viền
                                        width: 1.0, // Độ rộng của viền
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.phone_android, // Biểu tượng của phone
                                      color: Color.fromARGB(255, 3, 117, 210), // Màu biểu tượng
                                      size: 40, // Điều chỉnh kích thước của biểu tượng
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Chưa có tài khoản?", style: TextStyle(fontSize: 16)),
                                  TextButton(
                                    onPressed: () {
                                      // Xử lí sự kiện đăng kí
                                    },
                                    child: Text('Đăng kí',  style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ), // Thay Placeholder bằng khung đăng nhập thực tế
                      ),
                    ),
                  ),
                  Container(
                    // Cột thứ hai: Hình ảnh
                    width: 900, // Điều chỉnh kích thước của hình ảnh
                    height: 900,
                    child: Image.asset('assets/picture/pic_register_login.png'), // Thay đường dẫn hình ảnh thực tế
                  ),
                ],
              ),
              // Dòng tiếp theo và các dòng sau trong cột đầu tiên
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
}