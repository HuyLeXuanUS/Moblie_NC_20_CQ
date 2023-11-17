import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_tutor.dart';
import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:readmore/readmore.dart';

// Màn hình chi tiết giáo viên
class TeacherDetailPage extends StatefulWidget {
  final String id;
  const TeacherDetailPage({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetailPage> {
  DateTime currentDate = DateTime.now();
  bool loading = false;
  Tutor? tutor;

  VideoPlayerController? _controller;

  TextStyle get primayryStyle => Theme.of(context)
      .textTheme
      .titleSmall!
      .copyWith(color: Theme.of(context).primaryColor);

  @override
  void initState() {
    fetchDetailTutor();
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
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
    if (dataResponse.video?.isNotEmpty ?? false) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(dataResponse.video.toString()));
    }
  }

  void nextDays(int days) {
    setState(() {
      currentDate = currentDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Thời gian')),
      DataColumn(label: Text('${currentDate.day}/${currentDate.month}')),
      DataColumn(
          label: Text(
              '${currentDate.add(Duration(days: 1)).day}/${currentDate.add(Duration(days: 1)).month}')),
      DataColumn(
          label: Text(
              '${currentDate.add(Duration(days: 2)).day}/${currentDate.add(Duration(days: 2)).month}')),
    ];

    List<DataRow> rows = List.generate(10, // Số dòng (các khoảng thời gian)
      (index) {
        final timeSlot =
            '00:${(index * 5).toString().padLeft(2, '0')}-${(index * 5 + 25).toString().padLeft(2, '0')}';
        return DataRow(cells: [
          DataCell(Text(timeSlot)),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.day}/${currentDate.month}');
            },
            child: Text('Đặt lịch'),
          )),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.add(Duration(days: 1)).day}/${currentDate.add(Duration(days: 1)).month}');
            },
            child: Text('Đặt lịch'),
          )),
          DataCell(ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút đặt lịch
              //print('Đặt lịch cho $timeSlot vào ngày ${currentDate.add(Duration(days: 2)).day}/${currentDate.add(Duration(days: 2)).month}');
            },
            child: Text('Đặt lịch'),
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
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (_controller != null) {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      }
                    });
                  },
                  child: Icon(
                    _controller?.value.isPlaying ?? false
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
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
                                          Text(
                                            CountryCode.fromCountryCode(
                                              tutor!.country!.toUpperCase(),
                                            ).name ??
                                            '',
                                          ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (_controller != null &&
                                _controller!.value.isInitialized)
                              SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Center(
                                    child: AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                )),
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
                                      icon: Icon(Icons.chat),
                                      onPressed: () {
                                        // Xử lý khi nhấn nút "Chat"
                                      },
                                    ),
                                    Text('Chat'),
                                  ],
                                ),

                                // Button "Favorite"
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.favorite),
                                      onPressed: () {
                                        // Xử lý khi nhấn nút "Favorite"
                                      },
                                    ),
                                    Text('Favorite'),
                                  ],
                                ),

                                // Button "Report"
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.report),
                                      onPressed: () {
                                        // Xử lý khi nhấn nút "Report"
                                      },
                                    ),
                                    Text('Report'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                                child:
                                    Text('Đây là row cho thông tin cá nhân')),
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
                                      'Từ ${currentDate.day}/${currentDate.month} đến ${currentDate.add(Duration(days: 2)).day}/${currentDate.add(Duration(days: 2)).month}',
                                      style: TextStyle(fontSize: 18),
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
                        title: Text('Đánh giá'),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: 6, // Số lượng mục trong danh sách
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    // Cột 1: Avatar
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(
                                          'assets/pic/bg_login.jpg'), // Đổi thành hình ảnh avatar thực tế
                                    ),
                                    SizedBox(
                                        width: 16), // Khoảng cách giữa hai cột

                                    // Cột 2: Tên, 5 ngôi sao và đánh giá
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tên người dùng #$index', // Thay thế bằng tên người dùng thực tế
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 18),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 18),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 18),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 18),
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 18),
                                          ],
                                        ),
                                        Text(
                                          'Đánh giá: 5.0', // Thay thế bằng đánh giá thực tế
                                          style: TextStyle(fontSize: 14),
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
