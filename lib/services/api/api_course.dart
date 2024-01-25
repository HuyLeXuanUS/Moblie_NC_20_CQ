// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_project/services/share_local/token_manager.dart';
import 'package:final_project/services/models/course/course_caterogy_model.dart';
import 'package:final_project/services/models/course/course_model.dart';
import 'package:final_project/services/setting/host_api.dart';

class CourseFunctions {
  static Future<List<Course>?> getListCourseWithPagination(
    int page,
    int size, {
    String q = "",
    String categoryId = "",
  }) async {
    String? token = await TokenManager.getToken();

    final queryParameters = {
      'page': '$page',
      'size': '$size',
    };

    if (q.isNotEmpty) {
      queryParameters.addAll({'q': q});
    }

    if (categoryId.isNotEmpty) {
      queryParameters.addAll({'categoryId[]': categoryId});
    }

    var url = Uri.https(apiUrl, 'course', queryParameters);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res['data']['rows'] as List;
      final arr = courses.map((e) => Course.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }

  static Future<List<CourseCategory>?> getAllCourseCategories() async {
    String? token = await TokenManager.getToken();

    var url = Uri.https(apiUrl, 'content-category');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res['rows'] as List;
      final arr = courses.map((e) => CourseCategory.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }

  static getCourseById(String courseId) async {
    String? token = await TokenManager.getToken();

    var url = Uri.https(apiUrl, 'course/$courseId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final course = Course.fromJson(res['data']);
      return course;
    } else {
      return null;
    }
  }
}
