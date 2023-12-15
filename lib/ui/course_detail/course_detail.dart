import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_course.dart';
import 'package:final_project/services/setting/course_level.dart';
import 'package:final_project/services/models/course/course_model.dart';
import 'package:flutter/material.dart';

// Màn hình chi tiết khóa học
class CourseDetailPage extends StatefulWidget {
  final String id;
  const CourseDetailPage({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetailPage> {
  bool loading = false;
  Course? course;

  @override
  void initState() {
    fetchDetailCourse();
    super.initState();
  }

  Future<void> fetchDetailCourse() async {
    setState(() {
      loading = true;
    });

    final dataResponse = await CourseFunctions.getCourseById(widget.id);
    if (dataResponse == null) {
      loading = false;
      return;
    }

    setState(() {
      course = dataResponse;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
    ? const Center(child: CircularProgressIndicator())
    : course == null
    ? const SizedBox()
    : Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 141, 204, 213),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Thông tin khóa học',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: course!.imageUrl.toString(),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      course!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(course!.description),
                  ),                           
                  Padding(
                    padding: const EdgeInsets.all(16.0), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, // Để canh chỉnh nút theo chiều ngang
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
              title: const Text('Tổng quan'),
              children: [
                ListTile(
                  title: const Text('❓ Tại sao bạn nên học khóa học này?'),
                  subtitle: Text(
                    course!.reason,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  title: const Text('❓ Bạn có thể làm gì?'),
                  subtitle:
                    Text(
                      course!.purpose,
                      style: const TextStyle(fontSize: 16),
                    ),
                ),
              ],
            ),
            const Divider(), // Dùng để tạo đường ngăn các
            // Mục Trình độ yêu cầu
            ListTile(
              title: const Text('Trình độ yêu cầu'),
              subtitle: Text(
                course_level[int.parse(course!.level)],
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(),
            // Mục Thời lượng khóa học
            ListTile(
              title: const Text('Thời lượng khóa học'),
              subtitle: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  course!.topics.length.toString()+' '+'Lessons',
                  style: const TextStyle(fontSize: 16),
                ),
            ),
            const Divider(),
            // Mục Danh sách chủ đề (sử dụng ListView cho danh sách chủ đề)
            ExpansionTile(
              title: const Text('Danh sách chủ đề'),
              children: [
                ListView.builder(
                  shrinkWrap:
                      true, // Để tránh lỗi vượt quá giới hạn trong ExpansionTile
                  itemCount: course!.topics.length, // Số lượng chủ đề
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Xử lý khi nút được nhấn
                      },
                      child: ListTile(
                        // ignore: prefer_interpolation_to_compose_strings
                        title: Text((index + 1).toString() + '. '+ course!.topics[index].name), // Tên của chủ đề
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
