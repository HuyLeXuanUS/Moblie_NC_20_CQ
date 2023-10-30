import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Màn hình chi tiết giáo viên
class TeacherDetailPage extends StatefulWidget{
  @override
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetailPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 204, 213), // Đặt màu nền thành màu trắng
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Thông tin gia sư', style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
              )
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Màu nền avatar
                    ),
                    child: Center(
                      child: Text('Avatar'),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Cột 2: Thông tin
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tên Giáo viên'),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          Text('(122)'),
                        ],
                      ),
                      Text('Quốc tịch'),
                    ],
                  ),
                ],
              ),
              Text('Đây là dòng cho video'),
              Text('Đây là dòng cho mô tả'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Button "Chat"
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chat),
                        onPressed: () {
                          // Xử lý khi nhấn nút "Chat"
                        },
                      ),
                      Text('Chat'),
                    ],
                  ),

                  // Button "Favorite"
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          // Xử lý khi nhấn nút "Favorite"
                        },
                      ),
                      Text('Favorite'),
                    ],
                  ),
                  
                  // Button "Report"
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.report),
                        onPressed: () {
                          // Xử lý khi nhấn nút "Report"
                        },
                      ),
                      Text('Report'),
                    ],
                  ),
                ],
              ),
              Text('Đây là row cho thông tin cá nhân'),
              DataTable(
                columns: [
                  DataColumn(label: Text('Thời gian')),
                  DataColumn(label: Text('Ngày')),
                ],
                rows: List.generate(
                  6, // Số dòng (các khoảng thời gian)
                  (index) {
                    final timeSlot = '00:${(index * 5).toString().padLeft(2, '0')}-${(index * 5 + 25).toString().padLeft(2, '0')}';
                    final date = DateTime.now().add(Duration(days: index));
                    return DataRow(cells: [
                      DataCell(Text(timeSlot)),
                      DataCell(ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nhấn nút đặt lịch
                          print('Đặt lịch cho $timeSlot vào ngày $date');
                        },
                        child: Text('Đặt lịch'),
                      )),
                    ]);
                  },
                ),
              ),
              Text('Đánh giá'),
            ],
          )
        ),
      ),
    );
  }
}