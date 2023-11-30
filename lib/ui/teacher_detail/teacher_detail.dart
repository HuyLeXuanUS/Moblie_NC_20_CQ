import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_tutor.dart';
import 'package:final_project/services/models/tutor/feedback_model.dart';
import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:final_project/services/setting/countries_list.dart';
import 'package:final_project/services/setting/learning_topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:video_player/video_player.dart';
import 'package:readmore/readmore.dart';

// Màn hình chi tiết giáo viên
class TeacherDetailPage extends StatefulWidget {
  final String id;
  final List<FeedBack>? listFeedback;
  const TeacherDetailPage({super.key, required this.id, required this.listFeedback});

  @override
  // ignore: library_private_types_in_public_api
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetailPage> {
  DateTime currentDate = DateTime.now();
  bool loading = false;
  Tutor? tutor;

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

    final dataResponse = await TutorFunctions.getTutorInfomation(widget.id);
    if (dataResponse == null) {
      return;
    }

    setState(() {
      tutor = dataResponse;
      loading = false;
    });
  }

  void nextDays(int days) {
    setState(() {
      currentDate = currentDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      const DataColumn(label: Text('Thời gian')),
      DataColumn(label: Text('${currentDate.day}/${currentDate.month}')),
      DataColumn(
          label: Text(
              '${currentDate.add(const Duration(days: 1)).day}/${currentDate.add(const Duration(days: 1)).month}')),
      DataColumn(
          label: Text(
              '${currentDate.add(const Duration(days: 2)).day}/${currentDate.add(const Duration(days: 2)).month}')),
    ];

    List<DataRow> rows = List.generate(10, (index) {
      final timeSlot = '00:${(index * 5).toString().padLeft(2, '0')}-${(index * 5 + 25).toString().padLeft(2, '0')}';
        return DataRow(cells: [
          DataCell(Text(timeSlot)),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.day}/${currentDate.month}');
            },
            child: const Text('Đặt lịch'),
          )),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.add(Duration(days: 1)).day}/${currentDate.add(Duration(days: 1)).month}');
            },
            child: const Text('Đặt lịch'),
          )),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.add(Duration(days: 2)).day}/${currentDate.add(Duration(days: 2)).month}');
            },
            child: const Text('Đặt lịch'),
          )),
        ]);
      },
    );

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
                )
              ),
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
                                  if (countryList.containsKey(tutor!.country))
                                    Text(
                                      countryList[tutor!.country].toString(),
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
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                // Xử lý khi nhấn nút "Favorite"
                              },
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
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
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                tutor!.education.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(listLearningTopics[e].toString()),
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
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
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
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Text(
                        tutor!.experience.toString(),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => nextDays(-3),
                            ),
                            Text(
                              'Từ ${currentDate.day}/${currentDate.month} đến ${currentDate.add(const Duration(days: 2)).day}/${currentDate.add(const Duration(days: 2)).month}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () => nextDays(3),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 10,
                            columns: columns,
                            rows: rows
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                title: const Text('Người khác đánh giá'),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.listFeedback?.length, 
                    itemBuilder: (context, index) {
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
                                  imageUrl: widget.listFeedback![index].firstInfo.avatar.toString(),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16), 
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.listFeedback![index].firstInfo.name.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
