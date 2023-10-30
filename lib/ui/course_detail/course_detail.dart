import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Màn hình chi tiết khóa học
class CourseDetailPage extends StatefulWidget{
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetailPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 204, 213), // Đặt màu nền thành màu trắng
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Thông tin khóa học', style: TextStyle(
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
                  // Hàng thứ nhất: Hình ảnh
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/picture/bg_login.jpg'),
                        fit: BoxFit.cover, // Làm cho hình ảnh lấp đầy và không cắt bất kỳ phần nào
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // Hàng thứ hai: Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tên khóa học',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Hàng thứ ba: Text thông tin
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Mô tả ngắn gọn khóa học'),
                  ),
                  // Hàng thứ tư: Hai TextButton
                  Padding(
                    padding: EdgeInsets.all(16.0), // Thay đổi giá trị padding tùy ý
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Để canh chỉnh nút theo chiều ngang
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nút được nhấn
                          },
                          child: const Text('Khám phá'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Mục Tổng quan
            ExpansionTile(
              title: Text('Tổng quan'),
              children: [
                ListTile(
                  title: Text('Tại sao bạn nên học khóa học này?'),
                  subtitle: Text('Mô tả tại sao khóa học này quan trọng.'),
                ),
                ListTile(
                  title: Text('Bạn có thể làm gì?'),
                  subtitle: Text('Các khía cạnh cụ thể của khóa học.'),
                ),
              ],
            ),
            Divider(), // Dùng để tạo đường ngăn cách
      
            // Mục Trình độ yêu cầu
            ListTile(
              title: Text('Trình độ yêu cầu'),
              subtitle: Text('Thông tin về mức độ trình độ yêu cầu của khóa học.'),
            ),
            Divider(),
      
            // Mục Thời lượng khóa học
            ListTile(
              title: Text('Thời lượng khóa học'),
              subtitle: Text('Thông tin về thời lượng và lịch học của khóa học.'),
            ),
            Divider(),
      
            // Mục Danh sách chủ đề (sử dụng ListView cho danh sách chủ đề)
            ExpansionTile(
              title: Text('Danh sách chủ đề'),
              children: [
                ListView.builder(
                  shrinkWrap: true, // Để tránh lỗi vượt quá giới hạn trong ExpansionTile
                  itemCount: 7, // Số lượng chủ đề
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Xử lý khi nút được nhấn
                      },
                      child: ListTile(
                        title: Text('Chủ đề'), // Tên của chủ đề
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