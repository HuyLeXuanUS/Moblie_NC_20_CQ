import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_schedule.dart';
import 'package:final_project/services/api/api_user.dart';
import 'package:final_project/services/models/schedule/booking_infor_model.dart';
import 'package:final_project/services/models/user/user_information_model.dart';
import 'package:final_project/ui/account/profile.dart';
import 'package:flutter/material.dart';
import 'package:final_project/ui/account/setting.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                        const Text(
                          'Tổng số giờ học',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${totalHourLesson!.inHours} giờ ${totalHourLesson!.inMinutes.remainder(60)} phút',
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
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  user: user,
                                ),
                              ),
                            );
                          },
                          child: const Text('Hồ sơ',
                            style: TextStyle(
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
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingPage(),
                              ),
                            );
                          },
                          child: const Text('Cài đặt',
                            style: TextStyle(
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
                            //Navigator.pop(context);
                          },
                          child: const Text('Đăng xuất',
                            style: TextStyle(
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
}