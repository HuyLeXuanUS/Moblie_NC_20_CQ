import 'package:final_project/services/models/course/course_model.dart';

class CourseList{
  final String title;
  final List<Course> listCourse;

  CourseList({
    required this.title,
    required this.listCourse,
  });
}