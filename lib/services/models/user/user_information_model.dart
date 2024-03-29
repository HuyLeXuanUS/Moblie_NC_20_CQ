import 'package:final_project/services/models/tutor/feedback_model.dart';
import 'package:final_project/services/models/topic_and_test_preparation/learning_topic_model.dart';
import 'package:final_project/services/models/topic_and_test_preparation/test_preparation_model.dart';

class UserInfo {
  late String id;
  late String email;
  String? google;
  String? facebook;
  String? apple;
  late String name;
  late String avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  late bool isActivated;
  String? studySchedule;
  String? level;
  List<LearnTopic>? learnTopics;
  List<TestPreparation>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  List<FeedBack>? feedbacks;

  UserInfo({
    required this.id,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.name,
    required this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    required this.isActivated,
    this.studySchedule,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.feedbacks,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    List<LearnTopic> learnTopics = [];
    if (json['learnTopics'] != null) {
      for (var v in json['learnTopics']) {
        learnTopics.add(LearnTopic.fromJson(v));
      }
    }

    List<TestPreparation> testPreparations = [];
    if (json['testPreparations'] != null) {
      for (var v in json['testPreparations']) {
        testPreparations.add(TestPreparation.fromJson(v));
      }
    }

    List<FeedBack> feedbacks = [];
    if (json['feedbacks'] != null) {
      for (var v in json['feedbacks']) {
        feedbacks.add(FeedBack.fromJson(v));
      }
    }

    return UserInfo(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      phone: json['phone'],
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      google: json['google'],
      facebook: json['facebook'],
      apple: json['apple'],
      roles: json['roles']?.cast<String>(),
      studySchedule: json['studySchedule'],
      level: json['level'],
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      learnTopics: learnTopics,
      testPreparations: testPreparations,
      feedbacks: feedbacks,
    );
  }
}
