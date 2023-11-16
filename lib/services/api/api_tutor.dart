import 'package:http/http.dart' as http;

import 'package:final_project/services/models/tutor_model.dart';
import 'package:final_project/services/setting/host_api.dart';
import 'package:final_project/services/api/token_manager.dart';
import 'dart:convert';


class TutorFunctions{
  static Future<List<Tutor>?> getTutorList(int page, {int? perPage}) async {
    List<Tutor> tutorList = <Tutor>[];
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
        var tutorArray = jsonDecode(response.body)['tutors']['rows'];
        for (var tutor in tutorArray) {
          tutorList.add(Tutor.fromJson(tutor));
        }
        return tutorList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }
}