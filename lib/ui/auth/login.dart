import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/picture/bg_login.jpg"),
                fit: BoxFit.cover, // Cách ảnh bề mặt container
              ),
            ),

            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Widget icon
                Container(
                  margin: EdgeInsets.only(top: 60.0), // Điều chỉnh khoảng cách từ trên xuống
                  child: Image.asset(
                    "assets/picture/icon_lettutor.png",
                    width: 150, // Điều chỉnh kích thước ảnh
                    height: 150,
                  ),
                ),

                // Widget lettutor
                Text(
                  "Lettutor",
                  style: TextStyle(
                    fontSize: 35, 
                    color: Color.fromARGB(255, 7, 81, 208),
                    fontFamily: "MyFont",
                  ),
                ),

                // Container chứa các widget đăng nhập
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 112, 109, 109), // Màu viền
                      width: 1.0, // Độ rộng của viền
                    ),
                    borderRadius: BorderRadius.circular(20.0), // Bo viền với bán kính 10
                  ),
                  // Cột thứ nhất: Khung đăng nhập
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
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
                        SizedBox(height: 20),
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
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              // Xử lí sự kiện quên mật khẩu
                            },
                            child: Text('Quên mật khẩu?'),
                          ),
                        ),
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
                        SizedBox(height: 20),
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
                                color: null, // Màu nền
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
                        SizedBox(height: 10),
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
                
              ],
            ),
          ),   
        ),
      ),
    );
  }
}
