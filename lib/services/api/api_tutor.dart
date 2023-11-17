import 'package:final_project/services/entity/tutor_fav_entity.dart';
import 'package:http/http.dart' as http;

import 'package:final_project/services/models/tutor/tutor_model.dart';
import 'package:final_project/services/setting/host_api.dart';
import 'package:final_project/services/api/token_manager.dart';
import 'dart:convert';

class TutorFunctions {
  static Future<TutorFav?> getTutorList(int page, {int? perPage}) async {
    final TutorFav dataResponse = TutorFav(tutors: [], favorites: []);
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
}
