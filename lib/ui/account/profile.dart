import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/services/models/user/learning_topic_model.dart';
import 'package:final_project/services/models/user/test_preparation_model.dart';
import 'package:final_project/services/models/user/user_information_model.dart';
import 'package:final_project/services/setting/countries_list.dart';
import 'package:final_project/services/setting/learning_topics.dart';
import 'package:final_project/services/setting/user_level.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Màn hình chi tiết khóa học
class ProfilePage extends StatefulWidget{
  final UserInfo? user;
  const ProfilePage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage>{
  final TextEditingController nameController = TextEditingController();
  String selectedCountry = "";
  final TextEditingController birthdayController = TextEditingController();
  DateTime? _selectedDate;
  String selectedLevel = "";
  final TextEditingController studyScheduleController = TextEditingController();

  List<LearnTopic>? selectedTopics = [];
  List<TestPreparation>? selectedTestPreparation = [];
  List<String> stringSelectedStudy = [];

  final items = listLearningTopics.entries
      .map((entry) => MultiSelectItem<String>(entry.key, entry.value))
      .toList();
  
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
        birthdayController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
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

    for (int i = 0; i < selectedTopics!.length; i++){
      stringSelectedStudy.add(getKeyFromValue(selectedTopics![i].name.toString()));
    }

    for (int i = 0; i < selectedTestPreparation!.length; i++){
      stringSelectedStudy.add(getKeyFromValue(selectedTestPreparation![i].name.toString()));
    }
  }

  String getKeyFromValue(String value) {
    final entry = listLearningTopics.entries.firstWhere((entry) => entry.value == value, orElse: () => () as MapEntry<String, String>);
    return entry.key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 204, 213), // Đặt màu nền thành màu trắng
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Chỉnh sửa hồ sơ', style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
              )
            ),
          ],
        ),
         actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
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
                    child: Container(
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
                  ),
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user!.name.toString(), style: const TextStyle(fontSize: 24)),
                      SizedBox(
                        width: 200,
                        // ignore: prefer_interpolation_to_compose_strings
                        child: Text("ID: " + widget.user!.id.toString(), 
                          style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 99, 96, 96)),
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          
                        },
                        child: const Text('Đổi mật khẩu',  style: TextStyle(fontSize: 16)),
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
                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
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
                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
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
                        })
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        selectedCountry = value;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
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
                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
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
                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
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
                        })
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        selectedLevel = value;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Viền bo tròn
                      ),
                    ),
                  ),

                  const SizedBox(height: 15), 

                  MultiSelectDialogField(
                    items: items,
                    title: const Text('Lựa chọn chủ đề muốn học: ', style: TextStyle(fontSize: 16)),
                    buttonText: const Text('Muốn học: ', style: TextStyle(fontSize: 16)),
                    
                    initialValue: stringSelectedStudy,
                    onConfirm: (values) {
                      setState(() {
                        stringSelectedStudy.clear();
                        stringSelectedStudy = values;
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