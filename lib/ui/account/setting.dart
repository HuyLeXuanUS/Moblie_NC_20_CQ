// ignore_for_file: unused_field, prefer_final_fields
import 'package:final_project/services/share_local/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:provider/provider.dart';


// Màn hình chi cài đặt
class SettingPage extends StatefulWidget{
  const SettingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage>{
  String? selectedLanguage = '';
  String? selectedTheme = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    selectedLanguage = provider.language;
    if (provider.language == 'vi')
    {
      selectedLanguage = S.of(context).vietnamese;
    }
    else
    {
      selectedLanguage = S.of(context).english;
    }
    
    if (provider.theme == 'light')
    {
      selectedTheme = S.of(context).light;
    }
    else
    {
      selectedTheme = S.of(context).dark;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 204, 213), // Đặt màu nền thành màu trắng
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(S.of(context).setting, style: const TextStyle(
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
                child: Text(S.of(context).language, style: const TextStyle(fontSize: 16)),
              ),
              DropdownButton<String>(
                value: selectedLanguage,
                alignment: Alignment.center, // Đặt vị trí theo mong muốn
                items: <String>[S.of(context).vietnamese, S.of(context).english]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    if (value == S.of(context).vietnamese)
                    {
                      provider.updateLanguage('vi');
                    }
                    else
                    {
                      provider.updateLanguage('en');
                    }
                    S.load(Locale(provider.language.toString()));
                  });
                },
              ),
            ],
          ),
          // Dòng 2: Chọn Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Theme', style: TextStyle(fontSize: 16)),
              ),
              DropdownButton<String>(
                value: selectedTheme,
                alignment: Alignment.center,
                items: <String>[S.of(context).light, S.of(context).dark]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    if (value == S.of(context).light)
                    {
                      provider.updateTheme('light');
                    }
                    else
                    {
                      provider.updateTheme('dark');
                    }
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