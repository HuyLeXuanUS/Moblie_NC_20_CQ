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
            String date = getDate(DateTime.now()); // Dòng 1: DateTime
            //String avatarUrl = 'https://example.com/avatar.png'; // Đường dẫn ảnh đại diện
            String name = 'Tên giảng viên'; // Dòng 2: Tên người dùng
            String nationality = 'Quốc tịch'; // Dòng 2: Dòng 1
            String expansionTitle = 'Yêu cầu buổi học'; // Dòng 3: Expansion Title

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
                  Text(date, style: const TextStyle(fontSize: 18.0)), 
                  Text("Giờ học: 10:00 - 11:00", style: const TextStyle(fontSize: 18.0)), 
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        //backgroundImage: NetworkImage(avatarUrl),
                        radius: 30.0, // Cột 1: Avatar
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name, style: const TextStyle(fontSize: 18.0)), 
                          SizedBox(height: 8.0),
                          Text(nationality), 
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ExpansionTile(
                    title: Text(expansionTitle), 
                    children: <Widget>[
                      // Nội dung mở rộng (nếu có)
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Đánh giá của gia sư"), 
                    children: <Widget>[
                      // Nội dung mở rộng (nếu có)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Rating:', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, 
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                        },
                        child: const Text('Đánh giá buổi học'),
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

  String getTime(DateTime dateTime){
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}"; // Định dạng ngày
    String formattedTime = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}"; // Định dạng giờ và phút
    String result = formattedTime + "   " + formattedDate; // Ghép lại giờ và ngày thành chuỗi
    return result;
  }

  String getDate(DateTime dateTime){
    String result = "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}"; // Định dạng ngày
    return result;
  }
}