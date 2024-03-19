import 'package:final_project/services/models/tutor/tutor_model.dart';

class TutorListHasFavourite {
  final List<Tutor> tutors;
  final List<String> favorites;
  TutorListHasFavourite({
    required this.tutors,
    required this.favorites,
  });
}
