import 'package:flutter/material.dart';

class ListTeacherPage extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacherPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 204, 213),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Nhập tên gia sư...',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Xử lý sự kiện tìm kiếm
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Lọc 1'),
                  value: 'filter1',
                ),
                PopupMenuItem(
                  child: Text('Lọc 2'),
                  value: 'filter2',
                ),
              ];
            },
            onSelected: (value) {
              // Xử lý sự kiện lọc
            },
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 10, // Số lượng containers bạn muốn hiển thị
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Hàng thứ nhất
                  Row(
                    children: [
                      // Cột 1: Avatar hình tròn
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
                          Text('Tên Giáo viên $index'),
                          Text('Quốc tịch'),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(Icons.star, color: Colors.yellow);
                            }),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      // Cột 3: Icon trái tim
                      Icon(Icons.favorite_border, color: Colors.red),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Hàng thứ hai: Thẻ text
                  Wrap(
                    spacing: 8.0,
                    children: List.generate(5, (index) {
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text('Môn học $index'),
                      );
                    }),
                  ),
                  SizedBox(height: 16.0),
                  // Hàng thứ ba: Text thông tin
                  Text('Thông tin về giáo viên $index'),
                  SizedBox(height: 16.0),
                  // Hàng thứ tư: Hai TextButton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Xử lý khi nhấn nút "Book"
                        },
                        child: Text('Book'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Xử lý khi nhấn nút "Chat"
                        },
                        child: Text('Chat'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
