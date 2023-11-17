import 'dart:async';

import 'package:flutter/material.dart';
import 'package:final_project/ui/teacher_detail/teacher_detail.dart';
import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:final_project/services/api/api_tutor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacherPage> {
  List<Tutor> tutorList = List.empty(growable: true);
  List<String> favoriteList = List.empty(growable: true);

  ScrollController? _scrollController;
  int currentPage = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_listenerScroll);

    fetchTutorList();
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        fetchTutorList();
      }
    }
  }

  Future<void> fetchTutorList() async {
    if(loading){
      return;
    }
    setState(() {
      loading = true;
    });
    final dataResponse =
        await TutorFunctions.getTutorList(currentPage + 1, perPage: 10);

    if (dataResponse == null) {
      return;
    }
    final tutors = dataResponse.tutors;
    final favorites = dataResponse.favorites;
    setState(() {
      if (favorites.isNotEmpty) {
        favoriteList.addAll(favorites);
      }
      if (tutors.isNotEmpty) {
        tutorList.addAll(tutors);
        currentPage += 1;
        loading = false;
      }
    });
    // Xử lý khi không lấy được dữ liệu
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
      body: Scrollbar(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          controller: _scrollController,
          itemCount: tutorList.length + 1,
          itemBuilder: (context, index) {
            if (index < tutorList.length) {
              return _teacherItem(context, tutorList[index], index);
            }
            if (index >= tutorList.length && (loading)) {
              Timer(const Duration(milliseconds: 30), () {
                _scrollController!.jumpTo(
                  _scrollController!.position.maxScrollExtent,
                );
              });
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  InkWell _teacherItem(BuildContext context, Tutor tutor, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TeacherDetailPage(id: tutor.userId),
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
                      imageUrl: tutor.avatar.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                      RatingBar.builder(
                        initialRating: tutor.rating ?? 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
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
                  child: Icon(
                    favoriteList.contains(tutor.userId)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Colors.red,
                  ), // Sử dụng Icon(Icons.favorite) để hiển thị icon đỏ
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: tutor.specialties
                        ?.split(',')
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(e),
                          ),
                        )
                        .toList() ??
                    []),
            const SizedBox(height: 16.0),
            Text(
              tutor.bio ?? "",
              maxLines: 4,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút "Book"
                  },
                  child: const Text('Book'),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút "Chat"
                  },
                  child: const Text('Chat'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
