import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:final_project/services/api/api_schedule.dart';
import 'package:final_project/services/models/schedule/booking_infor_model.dart';
import 'package:final_project/utils/join_meeting.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
      loading = false;
      return;
    }

    setState(() {
      if (dataResponse.isNotEmpty) {
        listBooking?.addAll(dataResponse);
        currentPage += 1;
      }
      loading = false;
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
                    // ignore: unused_local_variable
                    DateTime startDateTime =
                        DateTime.fromMillisecondsSinceEpoch(listBooking![index]
                            .scheduleDetailInfo!
                            .startPeriodTimestamp);

                    // ignore: unused_local_variable
                    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(
                        listBooking![index]
                            .scheduleDetailInfo!
                            .endPeriodTimestamp);

                    // ignore: prefer_interpolation_to_compose_strings
                    String timeStart = startDateTime.hour.toString().padLeft(2, '0') +
                            ":" +
                            startDateTime.minute.toString().padLeft(2, '0');
                    // ignore: prefer_interpolation_to_compose_strings
                    String timeEnd = endDateTime.hour.toString().padLeft(2, '0') +
                            ":" +
                            endDateTime.minute.toString().padLeft(2, '0');
                    // ignore: prefer_interpolation_to_compose_strings
                    String datetime =
                        // ignore: prefer_interpolation_to_compose_strings
                        getDate(startDateTime) +
                            "   " +
                            timeStart +
                            " - " +
                            timeEnd;
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
                      studentRequest = S.of(context).no_requests_for_this_class;
                    }
                    String detailId = listBooking![index].id.toString();

                    return _scheduleItem(startDateTime, datetime, avatarUrl,
                        name, studentRequest, detailId, listBooking![index]);
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
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning, color: Colors.orange, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    S.of(context).no_class_schedules_yet,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
    );
  }

  Container _scheduleItem(
      DateTime startDateTime,
      String datetime,
      String avatar,
      String name,
      String studentRequest,
      String detailId,
      BookingInfo nextClass) {
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
          DateTime.now().add(const Duration(hours: 2)).isBefore(startDateTime)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        await ScheduleFunctions.cancelClass(detailId);
                        setState(() {
                          listBooking!
                              .removeWhere((element) => element.id == detailId);
                        });
                        showTopSnackBar(
                          // ignore: use_build_context_synchronously
                          Overlay.of(context),
                          CustomSnackBar.error(
                            // ignore: use_build_context_synchronously
                            message: S.of(context).cancel_class_successfully,
                          ),
                          displayDuration: const Duration(seconds: 0),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        S.of(context).cancel_class,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        joinMeeting(nextClass);
                      },
                      child: Text(S.of(context).come_in_class),
                    ),
                  ],
                ),
          ExpansionTile(
            title: Text(S.of(context).request_lesson,
                style: const TextStyle(fontSize: 17.0)),
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
