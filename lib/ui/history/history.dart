import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget{
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 10, // Số lượng mục trong danh sách
          itemBuilder: (BuildContext context, int index) {
            // Thay đổi dữ liệu tại đây để phù hợp với nội dung mục
            String date = DateTime.now().toString(); // Dòng 1: DateTime
            //String avatarUrl = 'https://example.com/avatar.png'; // Đường dẫn ảnh đại diện
            String name = 'Người dùng'; // Dòng 2: Tên người dùng
            String subtitle1 = 'Dòng 2 - Dòng 1'; // Dòng 2: Dòng 1
            String subtitle2 = 'Dòng 2 - Dòng 2'; // Dòng 2: Dòng 2
            String expansionTitle = 'Tiêu đề mở rộng'; // Dòng 3: Expansion Title

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(date, style: const TextStyle(fontSize: 18.0)), // Dòng 1: DateTime
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        //backgroundImage: NetworkImage(avatarUrl),
                        radius: 30.0, // Cột 1: Avatar
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name, style: const TextStyle(fontSize: 18.0)), // Cột 2: Dòng 1
                          Text(subtitle1), // Cột 2: Dòng 2
                          Text(subtitle2), // Cột 2: Dòng 3
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Để canh chỉnh nút theo chiều ngang
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                        },
                        child: const Text('Nút 1'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                        },
                        child: const Text('Nút 2'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                        },
                        child: const Text('Nút 3'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(expansionTitle), // Dòng 3: Expansion Title
                    children: <Widget>[
                      // Nội dung mở rộng (nếu có)
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