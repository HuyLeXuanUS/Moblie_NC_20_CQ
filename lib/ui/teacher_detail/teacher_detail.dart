import 'package:flutter/material.dart';
//import 'package:video_player/video_player.dart';

// Màn hình chi tiết giáo viên
class TeacherDetailPage extends StatefulWidget{
  @override
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetailPage>{
  DateTime currentDate = DateTime.now();

  void nextDays(int days) {
    setState(() {
      currentDate = currentDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Thời gian')),
      DataColumn(label: Text('${currentDate.day}/${currentDate.month}')),
      DataColumn(label: Text('${currentDate.add(Duration(days: 1)).day}/${currentDate.add(Duration(days: 1)).month}')),
      DataColumn(label: Text('${currentDate.add(Duration(days: 2)).day}/${currentDate.add(Duration(days: 2)).month}')),
    ];

    List<DataRow> rows = List.generate(
      10, // Số dòng (các khoảng thời gian)
      (index) {
        final timeSlot = '00:${(index * 5).toString().padLeft(2, '0')}-${(index * 5 + 25).toString().padLeft(2, '0')}';
        return DataRow(cells: [
          DataCell(Text(timeSlot)),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.day}/${currentDate.month}');
            },
            child: Text('Đặt lịch'),
          )),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.add(Duration(days: 1)).day}/${currentDate.add(Duration(days: 1)).month}');
            },
            child: Text('Đặt lịch'),
          )),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.add(Duration(days: 2)).day}/${currentDate.add(Duration(days: 2)).month}');
            },
            child: Text('Đặt lịch'),
          )),
        ]);
      },
    );

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                  SizedBox(height: 16.0),
                  Container(
                    child: Text('Đây là row cho thông tin cá nhân')
                  ),
                  
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => nextDays(-3),
                          ),
                          Text(
                            'Từ ${currentDate.day}/${currentDate.month} đến ${currentDate.add(Duration(days: 1)).day}/${currentDate.add(Duration(days: 1)).month}',
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () => nextDays(3),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 10,
                          columns: columns, 
                          rows: rows
                        )
                      ),
                    ],
                  ),                                
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Đánh giá'),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 6, // Số lượng mục trong danh sách
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Cột 1: Avatar
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage('assets/pic/bg_login.jpg'), // Đổi thành hình ảnh avatar thực tế
                          ),
                          SizedBox(width: 16), // Khoảng cách giữa hai cột
          
                          // Cột 2: Tên, 5 ngôi sao và đánh giá
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tên người dùng #$index', // Thay thế bằng tên người dùng thực tế
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow, size: 18),
                                  Icon(Icons.star, color: Colors.yellow, size: 18),
                                  Icon(Icons.star, color: Colors.yellow, size: 18),
                                  Icon(Icons.star, color: Colors.yellow, size: 18),
                                  Icon(Icons.star, color: Colors.yellow, size: 18),
                                ],
                              ),
                              Text(
                                'Đánh giá: 5.0', // Thay thế bằng đánh giá thực tế
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}