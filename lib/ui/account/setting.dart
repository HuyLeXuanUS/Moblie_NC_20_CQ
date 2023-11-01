import 'package:flutter/material.dart';
import 'package:final_project/generated/l10n.dart';


// Màn hình chi cài đặt
class SettingPage extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage>{
  String? selectedLanguage = 'vi';
  String? selectedTheme = 'Sáng';

  Locale _locale_vn = Locale('vn');
  Locale _locale_en = Locale('en');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 204, 213), // Đặt màu nền thành màu trắng
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(S.of(context).setting, style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
              )
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          // Dòng 1: Chọn Ngôn ngữ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Ngôn ngữ', style: TextStyle(fontSize: 16)),
              ),
              DropdownButton<String>(
                value: selectedLanguage,
                alignment: Alignment.center, // Đặt vị trí theo mong muốn
                items: <String>['vi', 'en']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value ?? ''),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedLanguage = value;
                    S.load(Locale(value.toString()));
                  });
                },
              ),
            ],
          ),
          // Dòng 2: Chọn Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Theme', style: TextStyle(fontSize: 16)),
              ),
              DropdownButton<String>(
                value: selectedTheme,
                alignment: Alignment.center,
                items: <String>['Sáng', 'Tối']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value ?? ''),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedTheme = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}