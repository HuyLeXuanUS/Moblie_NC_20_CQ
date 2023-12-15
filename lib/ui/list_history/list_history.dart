import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_schedule.dart';
import 'package:final_project/services/models/schedule/booking_infor_model.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  List<BookingInfo>? listHistoryBooking = List.empty(growable: true);

  ScrollController? _scrollController;
  int currentPage = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_listenerScroll);
    fetchHistoryList();
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        fetchHistoryList();
      }
    }
  }

  Future<void> fetchHistoryList() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });

    final dataResponse =
        await ScheduleFunctions.getBookedClass(currentPage + 1, 10);

    if (dataResponse == null) {
      loading = false;
      return;
    }

    setState(() {
      if (dataResponse.isNotEmpty) {
        listHistoryBooking?.addAll(dataResponse);
        currentPage += 1;
      }
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          )
        : Scaffold(
            body: Scrollbar(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                controller: _scrollController,
                itemCount: listHistoryBooking!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < listHistoryBooking!.length) {
                    DateTime startDateTime =
                        DateTime.fromMillisecondsSinceEpoch(
                            listHistoryBooking![index]
                                .scheduleDetailInfo!
                                .startPeriodTimestamp);

                    // ignore: unused_local_variable
                    DateTime endDateTime =
                        DateTime.fromMillisecondsSinceEpoch(
                            listHistoryBooking![index]
                                .scheduleDetailInfo!
                                .endPeriodTimestamp);

                    // ignore: prefer_interpolation_to_compose_strings
                    String timeStart = startDateTime.hour
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        startDateTime.minute.toString().padLeft(2, '0');
                    // ignore: prefer_interpolation_to_compose_strings
                    String timeEnd = endDateTime.hour
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        endDateTime.minute.toString().padLeft(2, '0');

                    String date = getDate(startDateTime);                   
                    String avatarUrl = listHistoryBooking![index]
                        .scheduleDetailInfo!
                        .scheduleInfo!
                        .tutorInfo!
                        .avatar
                        .toString();
                    String name = listHistoryBooking![index]
                        .scheduleDetailInfo!
                        .scheduleInfo!
                        .tutorInfo!
                        .name
                        .toString();
                    String studentRequest =
                        listHistoryBooking![index].studentRequest.toString();
                    if (studentRequest == "null") {
                      studentRequest = "Không có yêu cầu cho buổi học";
                    }
                    String tutorReview =
                        listHistoryBooking![index].tutorReview.toString();
                    if (tutorReview == "null") {
                      tutorReview = "Không có dánh giá của gia sư";
                    }

                    return _historyItem(date, timeStart, timeEnd, avatarUrl,
                        name, studentRequest, tutorReview);
                  }
                  return const SizedBox();
                },
              ),
            ),
          );
  }

  Container _historyItem(String date, String timeStart, String timeEnd,
      String avatar, String name, String studentRequest, String tutorReview) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(date, style: const TextStyle(fontSize: 18.0)),
          // ignore: prefer_interpolation_to_compose_strings
          Text("Giờ học: " + timeStart + " - " + timeEnd,
              style: const TextStyle(fontSize: 18.0)),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatar,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: const TextStyle(fontSize: 18.0)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ExpansionTile(
            title: const Text("Yêu cầu buổi học",
                style: TextStyle(fontSize: 17.0)),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  studentRequest,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text("Đánh giá của gia sư",
                style: TextStyle(fontSize: 17.0)),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  tutorReview,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                'Rating:',
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.star, color: Colors.yellow, size: 18),
              Icon(Icons.star, color: Colors.yellow, size: 18),
              Icon(Icons.star, color: Colors.yellow, size: 18),
              Icon(Icons.star, color: Colors.yellow, size: 18),
              Icon(Icons.star, color: Colors.yellow, size: 18),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nút được nhấn
                },
                child: const Text('Đánh giá buổi học'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getDate(DateTime dateTime) {
    String result =
        "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}"; // Định dạng ngày
    return result;
  }
}
