import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_user.dart';
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
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    if (loading){
      return;
    }
    setState(() {
      loading = true;
    });
    user = await UserFunctions.getUserInformation();
    if (mounted) {
      setState(() {
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
                Text(user!.name.toString(), style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(user: user,),
                        ),
                      );
                    },
                    child: const Text('Hồ sơ'),
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
                    child: const Text('Cài đặt'),
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
                    child: const Text('Đăng xuất'),
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
