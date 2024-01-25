import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:final_project/services/api/api_schedule.dart';
import 'package:final_project/services/api/api_user.dart';
import 'package:final_project/services/models/schedule/booking_infor_model.dart';
import 'package:final_project/services/models/user/user_information_model.dart';
import 'package:final_project/ui/account/profile.dart';
import 'package:final_project/ui/auth/login.dart';
import 'package:final_project/utils/join_meeting.dart';
import 'package:flutter/material.dart';
import 'package:final_project/ui/account/setting.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  UserInfo? user;
  Duration? totalHourLesson;
  BookingInfo? nextClass;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    user = await UserFunctions.getUserInformation();
    final total = await ScheduleFunctions.getTotalHourLesson();
    final next = await ScheduleFunctions.getNextClass();
    if (mounted) {
      setState(() {
        totalHourLesson = Duration(minutes: total);
        nextClass = next;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String datetime = "";
    DateTime datetimeStart = DateTime.now();
    if (nextClass != null) {
      DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(
          nextClass!.scheduleDetailInfo!.startPeriodTimestamp);
      DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(
          nextClass!.scheduleDetailInfo!.endPeriodTimestamp);
      // ignore: prefer_interpolation_to_compose_strings
      String timeStart = startDateTime.hour.toString().padLeft(2, '0') +
          ":" +
          startDateTime.minute.toString().padLeft(2, '0');
      // ignore: prefer_interpolation_to_compose_strings
      String timeEnd = endDateTime.hour.toString().padLeft(2, '0') +
          ":" +
          endDateTime.minute.toString().padLeft(2, '0');
      datetime =
          // ignore: prefer_interpolation_to_compose_strings
          getDate(startDateTime) + "   " + timeStart + " - " + timeEnd;
      datetimeStart = startDateTime;
    }

    return loading
        ? Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          )
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: user!.avatar.toString(),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(user!.name.toString(),
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Next class
                  nextClass != null
                  ? Container(
                      width: double.infinity,
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
                          Center(
                            child: Text(S.of(context).upcoming_lesson,
                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),     
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: Text(datetime,
                              style: const TextStyle(fontSize: 18.0)),     
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: Countdown(
                              seconds: datetimeStart.difference(DateTime.now()).inSeconds.toInt(), 
                              build: (BuildContext context, double time) {
                                int hours = (time / 3600).floor();
                                int minutes = ((time % 3600) / 60).floor();
                                int seconds = (time % 60).floor();

                                String formattedHours = hours < 10 ? '0$hours' : '$hours';

                                // ignore: prefer_interpolation_to_compose_strings
                                return Text(S.of(context).start_in + ': $formattedHours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                  style: const TextStyle(fontSize: 18.0));
                              },
                              interval: const Duration(milliseconds: 100),
                              onFinished: () {},
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  print("Vào lớp học");
                                  joinMeeting(nextClass);
                                },
                                child: Text(S.of(context).come_in_class),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),

                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          S.of(context).total_lesson_time,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
                          '${totalHourLesson!.inHours}' + " " + S.of(context).hours + " " +'${totalHourLesson!.inMinutes.remainder(60) }' + " " + S.of(context).minutes,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  user: user,
                                ),
                              ),
                            )
                                .then((value) {
                              getUserProfile();
                            });
                          },
                          child: Text(
                            S.of(context).profile,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingPage(),
                              ),
                            )
                            .then((value) {
                              setState(() {
                              });
                            });
                          },
                          child: Text(
                            S.of(context).setting,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Dòng 4: Button Đăng xuất
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            S.of(context).logout,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  String getDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year.toString()}"; // Định dạng ngày
  }
}
