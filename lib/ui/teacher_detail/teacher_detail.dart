import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_schedule.dart';
import 'package:final_project/services/api/api_tutor.dart';
import 'package:final_project/services/models/schedule/schedule_model.dart';
import 'package:final_project/services/models/tutor/feedback_model.dart';
import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:final_project/services/setting/countries_list.dart';
import 'package:final_project/services/setting/learning_topics.dart';
import 'package:final_project/services/setting/test_preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:video_player/video_player.dart';
import 'package:readmore/readmore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// Màn hình chi tiết giáo viên
class TeacherDetailPage extends StatefulWidget {
  final String tutorId;
  final List<FeedBack>? listFeedback;
  const TeacherDetailPage(
      {super.key, required this.tutorId, required this.listFeedback});

  @override
  // ignore: library_private_types_in_public_api
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetailPage> {
  DateTime currentDate = DateTime.now();
  bool loading = false;
  Tutor? tutor;

  bool loadingSchedule = false;
  List<Schedule> listSchedules = List.empty(growable: true);
  bool isExpanded = false;

  //VideoPlayerController? _controller;

  TextStyle get primayryStyle => Theme.of(context)
      .textTheme
      .titleSmall!
      .copyWith(color: Theme.of(context).primaryColor);

  @override
  void initState() {
    super.initState();
    fetchDetailTutor();
  }

  Future<void> fetchDetailTutor() async {
    setState(() {
      loading = true;
    });

    final dataResponse =
        await TutorFunctions.getTutorInfomation(widget.tutorId);
    if (dataResponse == null) {
      return;
    }

    setState(() {
      tutor = dataResponse;
      loading = false;
    });
  }

  Future<void> fetchSchedule() async {
    setState(() {
      loadingSchedule = true;
    });

    final dataResponse =
        await ScheduleFunctions.getScheduleByTutorId(widget.tutorId);
    if (dataResponse == null) {
      return;
    }

    listSchedules = dataResponse;
    listSchedules = listSchedules.where((schedule) {
      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);
      return start.isAfter(now);
    }).toList();

    listSchedules
        .sort((s1, s2) => s1.startTimestamp.compareTo(s2.startTimestamp));

    for (var schedule in listSchedules) {
      schedule.tutorInfo = tutor;
    }

    setState(() {
      loadingSchedule = false;
    });
  }

  void nextDays(int days) {
    setState(() {
      currentDate = currentDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          )
        : tutor == null
            ? const SizedBox()
            : Scaffold(
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     setState(() {
                //       if (_controller != null) {
                //         _controller!.value.isPlaying
                //             ? _controller!.pause()
                //             : _controller!.play();
                //       }
                //     });
                //   },
                //   child: Icon(
                //     _controller?.value.isPlaying ?? false
                //         ? Icons.pause
                //         : Icons.play_arrow,
                //   ),
                // ),
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 141, 204, 213),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Thông tin gia sư',
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: tutor!.avatar.toString(),
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  // Cột 2: Thông tin
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tutor!.name.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: tutor!.rating ?? 0,
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
                                      if (tutor?.country?.isNotEmpty ?? false)
                                        if (tutor!.country!.length <= 2)
                                          if (countryList
                                              .containsKey(tutor!.country))
                                            Text(
                                              countryList[tutor!.country]
                                                  .toString(),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ReadMoreText(
                              tutor?.bio ?? "",
                              trimLines: 3,
                              trimCollapsedText: "Show more",
                              trimExpandedText: "Show less",
                              lessStyle: primayryStyle,
                              moreStyle: primayryStyle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Button "Chat"
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.chat),
                                      onPressed: () {
                                        // Xử lý khi nhấn nút "Chat"
                                      },
                                    ),
                                    const Text('Chat'),
                                  ],
                                ),

                                // Button "Favorite"
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Xử lý khi người dùng nhấn vào icon trái tim ở đây.
                                      },
                                      // ignore: unrelated_type_equality_checks
                                      child: Icon(
                                        tutor?.isFavorite.toString() == "true"
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const Text('Favorite'),
                                  ],
                                ),

                                // Button "Report"
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.report),
                                      onPressed: () {
                                        // Xử lý khi nhấn nút "Report"
                                      },
                                    ),
                                    const Text('Report'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Học vấn',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 16.0),
                              child: Text(
                                tutor!.education.toString(),
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ngôn ngữ',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        tutor!.languages.toString(),
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Chuyên ngành',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: tutor!.specialties
                                              ?.split(',')
                                              .map(
                                                (e) => Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: listLearningTopics
                                                          .containsKey(e)
                                                      ? Text(
                                                          listLearningTopics[e]
                                                              .toString(),
                                                        )
                                                      : Text(
                                                          listTestPreparation[e]
                                                              .toString(),
                                                        ),
                                                ),
                                              )
                                              .toList() ??
                                          []),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sở thích',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 16.0),
                              child: Text(
                                tutor!.interests.toString(),
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kinh nghiệm giảng dạy',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 16.0),
                              child: Text(
                                tutor!.experience.toString(),
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExpansionTile(
                          onExpansionChanged: (bool expanding) {
                            if (expanding) {
                              fetchSchedule();
                            }
                            setState(() {
                              isExpanded = expanding;
                            });
                          },
                          title: const Text('Đặt lịch học'),
                          children: [
                            loadingSchedule
                                ? const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 3, 117, 210),
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                                  )
                                : listSchedules.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Chưa có lịch học nào',
                                            style: TextStyle(fontSize: 14.0)),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: listSchedules.length,
                                        itemBuilder: (context, index) {
                                          return _itemSchedule(
                                              listSchedules[index]);
                                        }),
                          ]),
                      ExpansionTile(
                        title: const Text('Người khác đánh giá'),
                        children: [
                          widget.listFeedback!.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Chưa có đánh giá nào',
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: widget.listFeedback?.length,
                                  itemBuilder: (context, index) {
                                    return _itemFeedback(index);
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }

  Container _itemSchedule(Schedule schedule) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
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
          Text(
            getSTimeFromStartToEnd(
                DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp),
                DateTime.fromMillisecondsSinceEpoch(schedule.endTimestamp)),
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: schedule.isBooked ||
                        DateTime.fromMillisecondsSinceEpoch(
                                schedule.startTimestamp)
                            .isBefore(
                                DateTime.now().add(const Duration(hours: 2)))
                    ? null
                    : () async {
                        try {
                          // ignore: unused_local_variable
                          final dataresponse =
                              await ScheduleFunctions.bookAClass(
                                  schedule.id.toString());
                          print(schedule.id.toString());
                          print(schedule.tutorInfo);
                          print(dataresponse);
                          // ignore: unnecessary_null_comparison
                          if (dataresponse == null) {
                            return;
                          }
                          if (dataresponse && mounted) {
                            setState(() {});
                            showAboutDialog(context: context, children: [
                              const Text("Đặt lịch học thành công"),
                            ]);
                          } else {
                            showTopSnackBar(
                              // ignore: use_build_context_synchronously
                              Overlay.of(context),
                              const CustomSnackBar.error(
                                message: "Đặt lịch học thất bại",
                              ),
                            );
                          }
                        } catch (e) {
                          showTopSnackBar(
                            // ignore: use_build_context_synchronously
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: "Đặt lịch học thất bại",
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: schedule.isBooked
                        ? const Color.fromARGB(255, 92, 208, 102)
                        : const Color.fromARGB(255, 29, 142, 235)),
                child: Text(
                  DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp)
                          .isBefore(
                              DateTime.now().add(const Duration(hours: 2)))
                      ? 'Đã hết hạn đặt lịch'
                      : schedule.isBooked
                          ? 'Đã đặt lịch học'
                          : 'Đặt lịch học',
                  style: TextStyle(
                    color: schedule.isBooked ||
                            DateTime.fromMillisecondsSinceEpoch(
                                    schedule.startTimestamp)
                                .isBefore(DateTime.now()
                                    .add(const Duration(hours: 2)))
                        ? const Color.fromARGB(255, 0, 46, 8)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _itemFeedback(int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl:
                    widget.listFeedback![index].firstInfo.avatar.toString(),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.listFeedback![index].firstInfo.name.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RatingBar.builder(
                initialRating: widget.listFeedback?[index].rating ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 18,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              Text(
                widget.listFeedback?[index].content ?? "Không có nhận xét",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getSTimeFromStartToEnd(DateTime start, DateTime end) {
    return "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - ${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}  ${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')}/${start.year}";
  }
}
