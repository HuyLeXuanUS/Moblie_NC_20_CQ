import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_schedule.dart';
import 'package:final_project/services/models/schedule/booking_infor_model.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<SchedulePage> {
  List<BookingInfo>? listBooking = List.empty(growable: true);

  ScrollController? _scrollController;
  int currentPage = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_listenerScroll);
    fetchBookingList();
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        fetchBookingList();
      }
    }
  }

  Future<void> fetchBookingList() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });

    final dataResponse =
        await ScheduleFunctions.getUpcomingClass(currentPage + 1, 10);

    if (dataResponse == null) {
      return;
    }

    setState(() {
      if (dataResponse.isNotEmpty) {
        listBooking?.addAll(dataResponse);
        currentPage += 1;
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listBooking != null && listBooking!.isNotEmpty
          ? Scrollbar(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                controller: _scrollController,
                itemCount: listBooking!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < listBooking!.length) {
                    String date = getDate(DateTime.fromMillisecondsSinceEpoch(
                        listBooking![index]
                            .scheduleDetailInfo!
                            .startPeriodTimestamp));
                    String timeStart = listBooking![index]
                        .scheduleDetailInfo!
                        .startPeriod
                        .toString();
                    String timeEnd = listBooking![index]
                        .scheduleDetailInfo!
                        .endPeriod
                        .toString();
                    // ignore: prefer_interpolation_to_compose_strings
                    String datetime =
                        // ignore: prefer_interpolation_to_compose_strings
                        date + "   " + timeStart + " - " + timeEnd;
                    String avatarUrl = listBooking![index]
                        .scheduleDetailInfo!
                        .scheduleInfo!
                        .tutorInfo!
                        .avatar
                        .toString();
                    String name = listBooking![index]
                        .scheduleDetailInfo!
                        .scheduleInfo!
                        .tutorInfo!
                        .name
                        .toString();
                    String studentRequest =
                        listBooking![index].studentRequest.toString();
                    if (studentRequest == "null") {
                      studentRequest = "Không có yêu cầu cho buổi học";
                    }
                    return _scheduleItem(
                        datetime, avatarUrl, name, studentRequest);
                  }
                  if (index >= listBooking!.length && (loading)) {
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
            )
          : const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.orange, size: 48), // Kích thước biểu tượng
                SizedBox(height: 8),  // Khoảng cách giữa biểu tượng và văn bản
                Text(
                  "Chưa có lịch học nào",
                  style: TextStyle(fontSize: 20), // Kích thước văn bản
                ),
              ],
            ),
          ),
    );
  }

  Container _scheduleItem(
      String datetime, String avatar, String name, String studentRequest) {
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
          Text(datetime, style: const TextStyle(fontSize: 18.0)),
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
                children: [
                  Text(name, style: const TextStyle(fontSize: 18.0)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nút được nhấn
                },
                child: const Text('Vào lớp học'),
              ),
            ],
          ),
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
        ],
      ),
    );
  }

  String getDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}"; // Định dạng ngày
  }
}
