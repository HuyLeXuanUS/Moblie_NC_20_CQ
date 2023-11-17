import 'package:final_project/services/models/tutor/tutor_model.dart';

class TutorFav {
  final List<Tutor> tutors;
  final List<String> favorites;
  TutorFav({
    required this.tutors,
    required this.favorites,
  });
}
