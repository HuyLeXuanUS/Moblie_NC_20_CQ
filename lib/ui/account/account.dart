import 'package:flutter/material.dart';
import 'package:final_project/ui/account/setting.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            // Dòng 1: Avatar và Tên
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/pic/bg_login.jpg'), // Đặt hình ảnh avatar ở đây
                ),
                SizedBox(width: 10),
                Text('Tên của bạn', style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 20),
            // Dòng 2: Button Hồ sơ
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý khi nút Hồ sơ được nhấn
                    },
                    child: Text('Hồ sơ'),
                  ),
                ),
              ],
            ),
            // Dòng 3: Button Cài đặt
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ),
                      );
                    },
                    child: Text('Cài đặt'),
                  ),
                ),
              ],
            ),
            // Dòng 4: Button Đăng xuất
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý khi nút Đăng xuất được nhấn
                    },
                    child: Text('Đăng xuất'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
