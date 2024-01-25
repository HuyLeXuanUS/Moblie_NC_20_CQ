import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:final_project/services/api/api_course.dart';
import 'package:final_project/services/setting/course_level.dart';
import 'package:final_project/services/models/course/course_model.dart';
import 'package:final_project/ui/course_detail/course_detail.dart';
import 'package:flutter/material.dart';

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListCourseState createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCoursePage> {
  List<Course>? listCourse = List.empty(growable: true);
  List<Course>? listViewCourse = List.empty(growable: true);

  ScrollController? _scrollController;
  int currentPage = 0;
  bool loading = false;

  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  String selectedLevel = 'All';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_listenerScroll);

    fetchCourseList();
    selectedLevel = 'All';
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        fetchCourseList();
      }
    }
  }

  Future<void> fetchCourseList() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    final dataResponse =
        await CourseFunctions.getListCourseWithPagination(currentPage + 1, 10);

    if (dataResponse == null) {
      loading = false;
      return;
    }
    setState(() {
      if (dataResponse.isNotEmpty) {
        listCourse?.addAll(dataResponse);

        if (isSearch) {
          List<Course>? temp = dataResponse
              .where((course) =>
                  course.name
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
                  course.description
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
              .toList();
          listViewCourse?.addAll(temp);
        } else {
          if (selectedLevel != 'All') {
            List<Course>? temp = dataResponse
                .where((course) =>
                    course_level[int.parse(course.level)] == selectedLevel)
                .toList();
            listViewCourse?.addAll(temp);
          } else {
            listViewCourse?.addAll(dataResponse);
          }
        }
        currentPage += 1;
      }
      loading = false;
    });
  }

  void searchCourseByString(String search) {
    if (search.isEmpty) {
      setState(() {
        isSearch = false;
        listViewCourse = List.from(listCourse!);
      });
    } else {
      setState(() {
        isSearch = true;
        listViewCourse = listCourse
            ?.where((course) =>
                course.name.toLowerCase().contains(search.toLowerCase()) ||
                course.description.toLowerCase().contains(search.toLowerCase()))
            .toList();
      });
    }
  }

  void filterCourseList(String level) {
    if (level == 'All') {
      setState(() {
        listViewCourse = List.from(listCourse!);
      });
    } else {
      isSearch = false;
      setState(() {
        listViewCourse = listCourse
            // ignore: iterable_contains_unrelated_type
            ?.where((course) => course_level[int.parse(course.level)] == level)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 204, 213),
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            // ignore: prefer_interpolation_to_compose_strings
            hintText: S.of(context).enter_course_name + '...',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searchCourseByString(searchController.text);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                selectedLevel = value;
                searchController.text = '';
              });
              isSearch = false;
              listViewCourse?.clear();
              filterCourseList(value);
            },
            itemBuilder: (BuildContext context) => [
              'All',
              'Any-level',
              'Beginner',
              'Upper-Beginner',
              'Pre-Intermediate',
              'Intermediate',
              'Upper-Intermediate',
              'Pre-Advanced',
              'Advanced',
            ].map((String option) {
              return PopupMenuItem<String>(
                  value: option,
                  child: ListTile(
                    title: Text(option),
                    tileColor: option == selectedLevel ? Colors.blue : null,
                  ));
            }).toList(),
          ),
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          controller: _scrollController,
          itemCount: listViewCourse!.length + 1,
          itemBuilder: (context, index) {
            if (index < listViewCourse!.length) {
              return _courseItem(context, listViewCourse![index], index);
            }
            if (index >= listViewCourse!.length && (loading)) {
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

  InkWell _courseItem(BuildContext context, Course course, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(id: course.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: course.imageUrl.toString(),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                course.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(course.description),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    course_level[int.parse(course.level)],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '·',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${course.topics.length} Lessons',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
