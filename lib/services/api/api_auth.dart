// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:final_project/services/setting/host_api.dart';
import 'package:final_project/services/models/user/user_model.dart';
import 'package:final_project/services/models/http_response_model.dart';
import 'package:final_project/services/models/login_response_model.dart';
import 'dart:convert';

class AuthFunctions{
  static Future<Map<String, Object>> login(User user) async {
    try {
      var url = Uri.https(apiUrl, 'auth/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
          }));

      if (response.statusCode == 200) {
        String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
        return {
          'isSuccess': true,
          'token': token,
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<Map<String, Object>> register(User user) async {
    try {
      var url = Uri.https(apiUrl, 'auth/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
            'source': null
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'isSuccess': true,
          'message':
              'Register successfully, check your email to activate your account'
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }
}