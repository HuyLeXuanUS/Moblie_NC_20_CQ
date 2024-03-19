// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:final_project/services/models/http_response_model.dart';
import 'package:final_project/services/share_local/token_manager.dart';
import 'package:final_project/services/models/topic_and_test_preparation/learning_topic_model.dart';
import 'package:final_project/services/models/topic_and_test_preparation/test_preparation_model.dart';
import 'package:final_project/services/models/user/user_information_model.dart';
import 'dart:convert';
import 'package:final_project/services/envs/enviroment.dart';

class UserFunctions {
  static final String apiUrl = Enviroments.baseUrl;
  static Future<Map<String, Object>> forgotPassword(String email) async {
    try {
      var url = Uri.https(apiUrl, 'user/forgotPassword');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
          }));

      if (response.statusCode == 200) {
        return {
          'isSuccess': true,
          'message':
              'Email sent successfully, check your email to reset your password'
        };
      } else {
        return {
          'isSuccess': true,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<UserInfo?> getUserInformation() async {
    String? token = await TokenManager.getToken();

    var url = Uri.https(apiUrl, 'user/info');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final user = UserInfo.fromJson(json.decode(response.body)['user']);
      return user;
    } else {
      return null;
    }
  }

  static Future<List<LearnTopic>?> getAllLearningTopic() async {
    String? token = await TokenManager.getToken();

    var url = Uri.https(apiUrl, 'learn-topic');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTopics = jsonRes.map((e) => LearnTopic.fromJson(e)).toList();
      return allTopics;
    } else {
      return null;
    }
  }

  static Future<List<TestPreparation>?> getAllTestPreparation() async {
    String? token = await TokenManager.getToken();

    var url = Uri.https(apiUrl, 'test-preparation');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTestPreparation =
          jsonRes.map((e) => TestPreparation.fromJson(e)).toList();
      return allTestPreparation;
    } else {
      return null;
    }
  }

  static Future<UserInfo?> updateUserInformation(
      String name,
      String country,
      String birthday,
      String level,
      String studySchedule,
      List<String>? learnTopics,
      List<String>? testPreparations) async {
    String? token = await TokenManager.getToken(); 

    var url = Uri.https(apiUrl, 'user/info');
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          'country': country,
          'birthday': birthday,
          'level': level,
          'studySchedule': studySchedule,
          'learnTopics': learnTopics,
          'testPreparations': testPreparations,
        }));

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final user = UserInfo.fromJson(jsonRes['user']);
      return user;
    } else {
      return null;
    }
  }

  static Future<bool> uploadAvatar(String path) async {
    String? token = await TokenManager.getToken();

    final request = http.MultipartRequest(
        'POST', Uri.parse('https://$apiUrl/user/uploadAvatar'));

    final img = await http.MultipartFile.fromPath('avatar', path);

    request.files.add(img);
    request.headers.addAll({'Authorization': 'Bearer $token'});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
