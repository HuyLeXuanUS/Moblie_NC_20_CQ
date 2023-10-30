import 'package:final_project/ui/course_detail/course_detail.dart';
import 'package:flutter/material.dart';

class ListCoursePage extends StatefulWidget {
  @override
  _ListCourseState createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCoursePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 204, 213),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Nhập tên khóa học...',
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
        child: ListView.separated(
          itemCount: 4, // Số lượng danh sách
          separatorBuilder: (BuildContext context, int index) => Divider(), // Tạo đường ngăn cách giữa các danh sách
          itemBuilder: (BuildContext context, int index) {
            late String title;
            if (index == 0) {
              title = "English For Traveling";
            } else if (index == 1) {
              title = "English For Beginners";
            } else if (index == 2) {
              title = "Business English";
            } else if (index == 3) {
              title = "English For Kids";
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: 4, // Số lượng containers bạn muốn hiển thị trong danh sách này
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Điều hướng đến trang chi tiết và chuyển dữ liệu liên quan đến khóa học
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(),//teacherInfo: teacherInfo), // Truyền thông tin giáo viên vào trang chi tiết
                          ),
                        );
                      },
                      child: Container(
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
                                'Tên khóa học $index',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            // Hàng thứ ba: Text thông tin
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Thông tin về khóa học $index'),
                            ),
                            // Hàng thứ tư: Hai TextButton
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Độ khó',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '·',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Số bài học',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
