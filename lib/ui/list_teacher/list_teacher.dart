import 'dart:async';

import 'package:final_project/generated/l10n.dart';
import 'package:final_project/services/setting/learning_topics.dart';
import 'package:final_project/services/setting/test_preparation.dart';
import 'package:flutter/material.dart';
import 'package:final_project/ui/teacher_detail/teacher_detail.dart';
import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:final_project/services/api/api_tutor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListTeacherState createState() => _ListTeacherState();
}

class _ListTeacherState extends State<ListTeacherPage> {
  List<Tutor> tutorList = List.empty(growable: true);

  List<Tutor> filterTutorList = List.empty(growable: true);

  List<Tutor> viewTutorList = List.empty(growable: true);
  List<String> viewFavoriteTutorList = List.empty(growable: true);

  ScrollController? _scrollController;
  int currentPage = 0;
  int currentPageSearch = 0;
  bool loading = false;

  TextEditingController nameTutorController = TextEditingController();
  bool checkSearch = false;
  String selectedSpecialities = "All";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_listenerScroll);

    fetchTutorList();
    selectedSpecialities = 'All';
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        if (!checkSearch) {
          fetchTutorList();
        } else {
          searchTutorList();
        }
      }
    }
  }

  Future<void> fetchTutorList() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    final dataResponse =
        await TutorFunctions.getTutorList(currentPage + 1, perPage: 10);

    if (dataResponse == null) {
      loading = false;
      return;
    }
    final tutors = dataResponse.tutors;
    final favorites = dataResponse.favorites;
    setState(() {
      if (tutors.isNotEmpty) {
        tutorList.addAll(tutors);
        filterTutorList
            .addAll(getFilterTutorList(tutors, selectedSpecialities));
        viewTutorList.clear();
        viewTutorList.addAll(filterTutorList);
        currentPage += 1;
      }
      if (favorites.isNotEmpty) {
        viewFavoriteTutorList.addAll(favorites);
      }
      loading = false;
    });
    loading = false;
  }

  Future<void> searchTutorList() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    final dataResponse = await TutorFunctions.searchTutor(
        currentPageSearch + 1, 10,
        search: nameTutorController.text);
    if (dataResponse == null) {
      loading = false;
      return;
    }
    final tutors = dataResponse;
    setState(() {
      if (tutors.isNotEmpty) {
        viewTutorList.addAll(tutors);
        currentPageSearch += 1;
        loading = false;
      }
    });
    loading = false;
  }

  void filterList(String type) {
    setState(() {
      if (type == 'All') {
        filterTutorList = List.from(tutorList);
      } else {
        filterTutorList = tutorList
            .where((tutor) =>
                tutor.specialties
                    ?.split(',')
                    .map((e) => listTestPreparation[e])
                    .toList()
                    .contains(type) ==
                true ||
                tutor.specialties
                    ?.split(',')
                    .map((e) => listLearningTopics[e])
                    .toList()
                    .contains(type) == true)
            .toList();
      }
      selectedSpecialities = type;
      viewTutorList.clear();
      viewTutorList.addAll(filterTutorList);
    });
  }

  List<Tutor> getFilterTutorList(List<Tutor> tutorList, String type) {
    if (type == "All") {
      return tutorList;
    }
    return tutorList
        .where((tutor) =>
            tutor.specialties
                ?.split(',')
                .map((e) => listTestPreparation[e])
                .toList()
                .contains(type) == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 204, 213),
        title: TextField(
          controller: nameTutorController,
          decoration: InputDecoration(
            // ignore: prefer_interpolation_to_compose_strings
            hintText: S.of(context).enter_tutor_name + '...',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              checkSearch = true;
              currentPageSearch = 0;
              viewTutorList.clear();
              searchTutorList();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                selectedSpecialities = value;
              });
              checkSearch = false;
              viewTutorList.clear();
              filterList(value);
            },
            itemBuilder: (BuildContext context) => [
              'All',
              'STARTERS',
              'MOVERS',
              'FLYERS',
              'KET',
              'PET',
              'IELTS',
              'TOEFL',
              'TOEIC',
              'Business English',
              'English for Kids',
              'Conversational English'
            ].map((String option) {
              return PopupMenuItem<String>(
                value: option,
                child: ListTile(
                  title: Text(option),
                  tileColor:
                      option == selectedSpecialities ? Colors.blue : null,
                ),
              );
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
          itemCount: viewTutorList.length + 1,
          itemBuilder: (context, index) {
            if (index < viewTutorList.length) {
              return _teacherItem(context, viewTutorList[index], index);
            }
            if (index >= viewTutorList.length && (loading)) {
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
            builder: (context) => TeacherDetailPage(
                tutorId: tutor.userId, listFeedback: tutor.feedbacks),
          ),
        ).then((value) => {
          fetchTutorList(),
          selectedSpecialities = 'All',
      });
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
                InkWell(
                  onTap: () async {
                    await TutorFunctions.manageFavoriteTutor(tutor.userId);
                    setState(() {
                      if (viewFavoriteTutorList.contains(tutor.userId)) {
                        viewFavoriteTutorList.remove(tutor.userId);
                      } else {
                        viewFavoriteTutorList.add(tutor.userId);
                      }
                    });
                    showTopSnackBar(
                    // ignore: use_build_context_synchronously
                      Overlay.of(context),
                      CustomSnackBar.success(
                        // ignore: use_build_context_synchronously
                        message: S.of(context)
                            .successfully_updated_favorite_teachers,
                      ),
                      displayDuration: const Duration(seconds: 0),
                    );
                  },
                  child: Icon(
                    checkSearch && tutor.isFavorite.toString() == "true" ||
                            viewFavoriteTutorList.contains(tutor.userId)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Colors.red,
                  ),
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
                            child: listLearningTopics[e] != null ? 
                            Text(listLearningTopics[e].toString())
                            : Text(listTestPreparation[e].toString()),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TeacherDetailPage(
                            tutorId: tutor.userId, listFeedback: tutor.feedbacks),
                      ),
                    );
                  },
                  child: Text(S.of(context).book),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút "Chat"
                  },
                  child: Text(S.of(context).chat),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
