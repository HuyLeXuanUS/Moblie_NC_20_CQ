// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:final_project/services/entity/tutor_list_has_favorite_entity.dart';
import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:final_project/services/envs/enviroment.dart';
import 'package:final_project/services/share_local/token_manager.dart';
import 'dart:convert';

class TutorFunctions {
  static final String apiUrl = Enviroments.baseUrl;
  static Future<TutorListHasFavourite?> getTutorList(int page, {int? perPage}) async {
    final TutorListHasFavourite dataResponse = TutorListHasFavourite(tutors: [], favorites: []);
    try {
      String? token = await TokenManager.getToken();
      final queryParameters = {
        'page': '$page',
        if (perPage != null) 'perPage': '$perPage',
      };
      var url = Uri.https(apiUrl, 'tutor/more', queryParameters);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final tutorArray = jsonDecode(response.body)['tutors']['rows'];
        final favorites = jsonDecode(response.body)['favoriteTutor'];
        for (var tutor in tutorArray) {
          dataResponse.tutors.add(Tutor.fromJson(tutor));
        }
        for (var element in favorites) {
          if (element["secondId"]?.isNotEmpty ?? false) {
            dataResponse.favorites.add(element["secondId"]);
          }
        }
        return dataResponse;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<Tutor?> getTutorInfomation(String id) async {
    try {
      String? token = await TokenManager.getToken();
      var url = Uri.https(apiUrl, 'tutor/$id');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {      
        return Tutor.fromJson2(jsonDecode(response.body));
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<bool> manageFavoriteTutor(String id) async {
    try {
      String? token = await TokenManager.getToken();
      var url = Uri.https(apiUrl, 'user/manageFavoriteTutor');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'tutorId': id,
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
    }
  }

  static Future<List<Tutor>?> searchTutor(
    int page,
    int perPage, {
    String search = '',
  }) async {
    try {
      String? token = await TokenManager.getToken();
      final Map<String, dynamic> args = {
        'page': page,
        'perPage': perPage,
        'search': search,
      };

      final url = Uri.https(apiUrl, 'tutor/search');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(args),
      );

      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        final List<dynamic> tutors = jsonRes["rows"];
        return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }
}
