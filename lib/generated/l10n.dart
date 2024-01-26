// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// 'Setting'
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// 'Tutor'
  String get tutor {
    return Intl.message(
      'Tutor',
      name: 'tutor',
      desc: '',
      args: [],
    );
  }

  /// List tutor page
  /// 'Enter the tutor's name'
  String get enter_tutor_name {
    return Intl.message(
      'Enter the tutor\'s name',
      name: 'enter_tutor_name',
      desc: '',
      args: [],
    );
  }

  /// 'Book'
  String get book {
    return Intl.message(
      'Book',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// 'Chat'
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// 'Successfully updated favorite teachers'
  String get successfully_updated_favorite_teachers {
    return Intl.message(
      'Successfully updated favorite teachers',
      name: 'successfully_updated_favorite_teachers',
      desc: '',
      args: [],
    );
  }

  /// Tutor detail page
  /// 'Tutor information'
  String get tutor_information {
    return Intl.message(
      'Tutor information',
      name: 'tutor_information',
      desc: '',
      args: [],
    );
  }

  /// 'Favorite'
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// 'Report'
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// 'Education'
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// 'Languages'
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// 'Specialties'
  String get specialties {
    return Intl.message(
      'Specialties',
      name: 'specialties',
      desc: '',
      args: [],
    );
  }

  /// 'Interests'
  String get interests {
    return Intl.message(
      'Interests',
      name: 'interests',
      desc: '',
      args: [],
    );
  }

  /// 'Teaching experience'
  String get teaching_experience {
    return Intl.message(
      'Teaching experience',
      name: 'teaching_experience',
      desc: '',
      args: [],
    );
  }

  /// 'Book schedule'
  String get book_schedule {
    return Intl.message(
      'Book schedule',
      name: 'book_schedule',
      desc: '',
      args: [],
    );
  }

  /// 'There are no class schedules yet'
  String get no_class_schedules_yet {
    return Intl.message(
      'There are no class schedules yet',
      name: 'no_class_schedules_yet',
      desc: '',
      args: [],
    );
  }

  /// 'Others review'
  String get others_review {
    return Intl.message(
      'Others review',
      name: 'others_review',
      desc: '',
      args: [],
    );
  }

  /// 'There are no reviews yet'
  String get no_reviews_yet {
    return Intl.message(
      'There are no reviews yet',
      name: 'no_reviews_yet',
      desc: '',
      args: [],
    );
  }

  /// 'Book schedule successfully'
  String get book_schedule_successfully {
    return Intl.message(
      'Book schedule successfully',
      name: 'book_schedule_successfully',
      desc: '',
      args: [],
    );
  }

  /// 'Book schedule failed'
  String get book_schedule_failed {
    return Intl.message(
      'Book schedule failed',
      name: 'book_schedule_failed',
      desc: '',
      args: [],
    );
  }

  /// 'Appointment deadline expires'
  String get appointment_deadline_expires {
    return Intl.message(
      'Appointment deadline expires',
      name: 'appointment_deadline_expires',
      desc: '',
      args: [],
    );
  }

  /// 'Booked'
  String get booked {
    return Intl.message(
      'Booked',
      name: 'booked',
      desc: '',
      args: [],
    );
  }

  /// 'Book_button'
  String get book_button {
    return Intl.message(
      'Book_button',
      name: 'book_button',
      desc: '',
      args: [],
    );
  }

  /// List schedule page
  /// 'Currently there are no requests for this class'
  String get no_requests_for_this_class {
    return Intl.message(
      'Currently there are no requests for this class',
      name: 'no_requests_for_this_class',
      desc: '',
      args: [],
    );
  }

  /// 'Cancel class successfully'
  String get cancel_class_successfully {
    return Intl.message(
      'Cancel class successfully',
      name: 'cancel_class_successfully',
      desc: '',
      args: [],
    );
  }

  /// 'Cancel class'
  String get cancel_class {
    return Intl.message(
      'Cancel class',
      name: 'cancel_class',
      desc: '',
      args: [],
    );
  }

  /// 'Come in class'
  String get come_in_class {
    return Intl.message(
      'Come in class',
      name: 'come_in_class',
      desc: '',
      args: [],
    );
  }

  /// 'Request lesson'
  String get request_lesson {
    return Intl.message(
      'Request lesson',
      name: 'request_lesson',
      desc: '',
      args: [],
    );
  }

  /// 'Time study'
  String get time_study {
    return Intl.message(
      'Time study',
      name: 'time_study',
      desc: '',
      args: [],
    );
  }

  /// Tutor's review
  String get tutor_review{
    return Intl.message(
      'Tutor\'s review',
      name: 'tutor_review',
      desc: '',
      args: [],
    );
  }

  /// 'Evaluate the lesson'
  String get evaluate_the_lesson{
    return Intl.message(
      'Evaluate the lesson',
      name: 'evaluate_the_lesson',
      desc: '',
      args: [],
    );
  }

  /// List course page
  /// 'Enter the course name'
  String get enter_course_name {
    return Intl.message(
      'Enter the course name',
      name: 'enter_course_name',
      desc: '',
      args: [],
    );
  }

  /// 'No courses found'
  String get no_courses_found {
    return Intl.message(
      'No courses found',
      name: 'no_courses_found',
      desc: '',
      args: [],
    );
  }

  /// Course detail page
  /// 'Cource information'
  String get course_information {
    return Intl.message(
      'Cource information',
      name: 'course_information',
      desc: '',
      args: [],
    );
  }

  /// 'Overview'
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// 'Why take this course'
  String get why_take_this_course {
    return Intl.message(
      'Why take this course',
      name: 'why_take_this_course',
      desc: '',
      args: [],
    );
  }

  /// 'What will you be able to do'
  String get what_will_you_be_able_to_do {
    return Intl.message(
      'What will you be able to do',
      name: 'what_will_you_be_able_to_do',
      desc: '',
      args: [],
    );
  }

  /// 'Experience Level'
  String get experience_level {
    return Intl.message(
      'Experience Level',
      name: 'experience_level',
      desc: '',
      args: [],
    );
  }

  /// 'Course Length'
  String get course_length {
    return Intl.message(
      'Course Length',
      name: 'course_length',
      desc: '',
      args: [],
    );
  }

  /// 'List Topics'
  String get list_topics {
    return Intl.message(
      'List Topics',
      name: 'list_topics',
      desc: '',
      args: [],
    );
  }

  /// Account page
  /// 'Upcoming lesson'
  String get upcoming_lesson {
    return Intl.message(
      'Upcoming lesson',
      name: 'upcoming_lesson',
      desc: '',
      args: [],
    );
  }

  /// 'Start in: '
  String get start_in {
    return Intl.message(
      'Start in',
      name: 'start_in',
      desc: '',
      args: [],
    );
  }

  /// 'Total lesson time'
  String get total_lesson_time {
    return Intl.message(
      'Total lesson time',
      name: 'total_lesson_time',
      desc: '',
      args: [],
    );
  }

  /// 'hours'
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// 'minutes'
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }
  
  /// 'Profile'
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// 'Logout'
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// Profile page
  /// 'Edit profile'
  String get edit_profile {
    return Intl.message(
      'Edit profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// 'Update profile successfully'
  String get update_profile_successfully {
    return Intl.message(
      'Update profile successfully',
      name: 'update_profile_successfully',
      desc: '',
      args: [],
    );
  }

  /// 'Update profile failed'
  String get update_profile_failed {
    return Intl.message(
      'Update profile failed',
      name: 'update_profile_failed',
      desc: '',
      args: [],
    );
  }

  /// 'Change password'
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// 'Name'
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// 'Email address'
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// 'Country'
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// 'Phone number'
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// 'Birthday'
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// 'My level'
  String get my_level {
    return Intl.message(
      'My level',
      name: 'my_level',
      desc: '',
      args: [],
    );
  }

  /// 'Want to learn'
  String get want_to_learn {
    return Intl.message(
      'Want to learn',
      name: 'want_to_learn',
      desc: '',
      args: [],
    );
  }

  /// 'Study schedule'
  String get study_schedule {
    return Intl.message(
      'Study schedule',
      name: 'study_schedule',
      desc: '',
      args: [],
    );
  }

  /// 'Choose the topic you want to learn'
  String get choose_the_topic_you_want_to_learn {
    return Intl.message(
      'Choose the topic you want to learn',
      name: 'choose_the_topic_you_want_to_learn',
      desc: '',
      args: [],
    );
  }

  /// 'Language'
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// 'Vietnamese'
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// 'English'
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// 'Light'
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// 'Dark'
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
