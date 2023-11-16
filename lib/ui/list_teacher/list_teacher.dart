import 'package:flutter/material.dart';
import 'package:final_project/ui/teacher_detail/teacher_detail.dart';
import 'package:final_project/services/models/tutor_model.dart';
import 'package:final_project/services/api/api_tutor.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListTeacherPage extends StatefulWidget {
  @override
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacherPage>{
  List<Tutor>? tutorList;

  @override
  void initState() {
    super.initState();
    fetchTutorList();
  }

  Future<void> fetchTutorList() async {
    List<Tutor>? tutors = await TutorFunctions.getTutorList(1);

    if (tutors != null) {
      setState(() {
        tutorList = tutors;
        //
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Token Cleared'),
              content: Text(tutorList!.length.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        //
      });
    } else {
      // Xử lý khi không lấy được dữ liệu
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 204, 213),
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Nhập tên gia sư...',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Xử lý sự kiện tìm kiếm
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text('Lọc 1'),
                  value: 'filter1',
                ),
                const PopupMenuItem(
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
      body: tutorList == null
          ? const Center(
              child: CircularProgressIndicator(),
            ) 
      : Scrollbar(
        child: ListView.builder(
          itemCount: tutorList!.length,
          itemBuilder: (context, index) {
            if (tutorList != null && index < tutorList!.length) {
            Tutor tutor = tutorList![index]; 
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TeacherDetailPage(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(16.0),
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
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: tutor.avatar.toString(), // Đặt đường dẫn hình ảnh của giáo viên
                              placeholder: (context, url) => const CircularProgressIndicator(), // Hiển thị một biểu tượng loading khi hình ảnh đang được tải
                              errorWidget: (context, url, error) => const Icon(Icons.error), // Hiển thị một biểu tượng lỗi nếu có lỗi khi tải hình ảnh
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tutor.name.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0, 
                                ),
                              ),
                              Text(tutor.country.toString()),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(Icons.star, color: Colors.yellow);
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        // Cột 3: Icon trái tim
                        InkWell(
                          onTap: () {
                            // Xử lý khi người dùng nhấn vào icon trái tim ở đây.
                          },
                          child: Icon(Icons.favorite, color: Colors.red), // Sử dụng Icon(Icons.favorite) để hiển thị icon đỏ
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0, 
                      children: List.generate(5, (index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
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
              ),
            );
            }
          },
        ),
      ),
    );
  }
}
