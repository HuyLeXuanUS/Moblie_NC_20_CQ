import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/api/api_user.dart';
import 'package:final_project/services/models/topic_and_test_preparation/learning_topic_model.dart';
import 'package:final_project/services/models/topic_and_test_preparation/test_preparation_model.dart';
import 'package:final_project/services/models/user/user_information_model.dart';
import 'package:final_project/services/setting/countries_list.dart';
import 'package:final_project/services/setting/learning_topics.dart';
import 'package:final_project/services/setting/test_preparation.dart';
import 'package:final_project/services/setting/user_level.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// Màn hình chi tiết khóa học
class ProfilePage extends StatefulWidget {
  final UserInfo? user;
  const ProfilePage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  String selectedCountry = "";
  final TextEditingController birthdayController = TextEditingController();
  DateTime? _selectedDate;
  String selectedLevel = "";
  final TextEditingController studyScheduleController = TextEditingController();

  List<LearnTopic>? selectedTopics = [];
  List<TestPreparation>? selectedTestPreparation = [];

  List<String> stringSelectedTopic = [];
  List<String> stringSelectedTestPreparation = [];

  final items = [
    ...listLearningTopics.entries
        .map((entry) => MultiSelectItem<String>(entry.key, entry.value))
        .toList(),
    ...listTestPreparation.entries
        .map((entry) => MultiSelectItem<String>(entry.key, entry.value))
        .toList(),
  ];

  final ImagePicker picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        birthdayController.text =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, "0")}-${picked.day.toString().padLeft(2, "0")}";
      });
    }
  }

  void filterTopicsAndTestPreparation(List<String> list) {
    stringSelectedTopic.clear();
    stringSelectedTestPreparation.clear();

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((value) {
      if (listLearningTopics.containsKey(value)) {
        stringSelectedTopic.add(value);
      }
      if (listTestPreparation.containsKey(value)) {
        stringSelectedTestPreparation.add(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user!.name.toString();
    selectedCountry = widget.user!.country.toString();
    birthdayController.text = widget.user!.birthday.toString();
    selectedLevel = widget.user!.level.toString();

    selectedTopics = widget.user!.learnTopics;
    selectedTestPreparation = widget.user!.testPreparations;
    studyScheduleController.text = widget.user!.studySchedule.toString();

    for (int i = 0; i < selectedTopics!.length; i++) {
      stringSelectedTopic
          .add(getKey(listLearningTopics, selectedTopics![i].name.toString()));
    }

    for (int i = 0; i < selectedTestPreparation!.length; i++) {
      stringSelectedTestPreparation.add(getKey(
          listTestPreparation, selectedTestPreparation![i].name.toString()));
    }
  }

  String getKey(Map<dynamic, dynamic> list, dynamic value) {
    return list.keys.firstWhere((k) => list[k] == value, orElse: () => '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 141, 204, 213), // Đặt màu nền thành màu trắng
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Chỉnh sửa hồ sơ',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
                )),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              selectedTopics = stringSelectedTopic.map((selectedTopic) {
                return listLearnTopicModel.firstWhere(
                  (learnTopic) => learnTopic.key == selectedTopic,
                  orElse: () => LearnTopic(id: -1, name: "", key: ""),
                );
              }).toList();

              selectedTestPreparation =
                  stringSelectedTestPreparation.map((selectedTestPreparation) {
                return listTestPreparationModel.firstWhere(
                  (testPreparation) =>
                      testPreparation.key == selectedTestPreparation,
                  orElse: () => TestPreparation(id: -1, name: "", key: ""),
                );
              }).toList();

              if (nameController.text == '') {
                showTopSnackBar(
                // ignore: use_build_context_synchronously
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "Name is empty",
                  ),
                  displayDuration: const Duration(seconds: 0),
                );
              }

              final res = await UserFunctions.updateUserInformation(
                nameController.text,
                selectedCountry,
                birthdayController.text,
                selectedLevel,
                studyScheduleController.text,
                selectedTopics?.map((e) => e.id.toString()).toList(),
                selectedTestPreparation?.map((e) => e.id.toString()).toList(),
              );

              if (res != null && mounted) {
                showTopSnackBar(
                // ignore: use_build_context_synchronously
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: "Cập nhật thành công",
                  ),
                  displayDuration: const Duration(seconds: 0),
                );
              } else {
                showTopSnackBar(
                // ignore: use_build_context_synchronously
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "Cập nhật thất bại",
                  ),
                  displayDuration: const Duration(seconds: 0),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.user!.avatar.toString(),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.edit,
                                    size: 16, color: Colors.white),
                                onPressed: () async {
                                  var pickedFile = await picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 50);

                                  if (pickedFile != null) {
                                    final bool res =
                                        await UserFunctions.uploadAvatar(
                                            pickedFile.path);
                                    if (res) {
                                      final newUserInfo = await UserFunctions
                                          .getUserInformation();
                                      setState(() {
                                        widget.user?.avatar =
                                            newUserInfo!.avatar;
                                      });
                                    } else if (mounted) {
                                      var snackBar = const SnackBar(
                                        content: Text("Error Upload Avatar"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user!.name.toString(),
                          style: const TextStyle(fontSize: 24)),
                      SizedBox(
                        width: 200,
                        // ignore: prefer_interpolation_to_compose_strings
                        child: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          "ID: " + widget.user!.id.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 99, 96, 96)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Đổi mật khẩu',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tên: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Địa chỉ email: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: widget.user!.email.toString(),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Quốc gia: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    value: selectedCountry,
                    items: countryList.entries
                        .map((MapEntry<String, String> entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(
                          entry.value.length > 35
                              // ignore: prefer_interpolation_to_compose_strings
                              ? entry.value.substring(0, 35) + "..."
                              : entry.value,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        selectedCountry = value;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Số điện thoại: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: widget.user!.phone.toString(),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Ngày sinh: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: birthdayController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Trình độ: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    value: selectedLevel,
                    items: user_level.entries
                        .map((MapEntry<String, String> entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(
                          entry.value.length > 35
                              // ignore: prefer_interpolation_to_compose_strings
                              ? entry.value.substring(0, 35) + "..."
                              : entry.value,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        selectedLevel = value;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  MultiSelectDialogField(
                    items: items,
                    title: const Text('Lựa chọn chủ đề muốn học: ',
                        style: TextStyle(fontSize: 16)),
                    buttonText: const Text('Muốn học: ',
                        style: TextStyle(fontSize: 16)),
                    initialValue:
                        stringSelectedTopic + stringSelectedTestPreparation,
                    onConfirm: (values) {
                      setState(() {
                        filterTopicsAndTestPreparation(values);
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text('Lịch học: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: studyScheduleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
