import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/generated/l10n.dart';
import 'package:final_project/services/api/api_course.dart';
import 'package:final_project/services/setting/course_level.dart';
import 'package:final_project/services/models/course/course_model.dart';
import 'package:final_project/ui/course_detail/topic_pdf.dart';
import 'package:flutter/material.dart';

// Màn hình chi tiết khóa học
class CourseDetailPage extends StatefulWidget {
  final String id;
  const CourseDetailPage({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetailPage> {
  bool loading = false;
  Course? course;

  @override
  void initState() {
    fetchDetailCourse();
    super.initState();
  }

  Future<void> fetchDetailCourse() async {
    setState(() {
      loading = true;
    });

    final dataResponse = await CourseFunctions.getCourseById(widget.id);
    if (dataResponse == null) {
      loading = false;
      return;
    }

    setState(() {
      course = dataResponse;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
    ? const Center(child: CircularProgressIndicator())
    : course == null
    ? const SizedBox()
    : Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 141, 204, 213),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(S.of(context).course_information,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 3, 117, 210),
                  fontFamily: 'MyFont',
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: course!.imageUrl.toString(),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      course!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(course!.description),
                  ),
                ],
              ),
            ),
            // Mục Tổng quan
            ExpansionTile(
              title: Text(S.of(context).overview),
              children: [
                ListTile(
                  // ignore: prefer_interpolation_to_compose_strings
                  title: Text('❓ ' + S.of(context).why_take_this_course),
                  subtitle: Text(
                    course!.reason,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  // ignore: prefer_interpolation_to_compose_strings
                  title: Text('❓ ' +  S.of(context).what_will_you_be_able_to_do),
                  subtitle:
                    Text(
                      course!.purpose,
                      style: const TextStyle(fontSize: 16),
                    ),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).experience_level),
              subtitle: Text(
                course_level[int.parse(course!.level)],
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).course_length),
              subtitle: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  course!.topics.length.toString()+' '+'Lessons',
                  style: const TextStyle(fontSize: 16),
                ),
            ),
            const Divider(),
            ExpansionTile(
              title: Text(S.of(context).list_topics),
              children: [
                ListView.builder(
                  shrinkWrap:
                      true, 
                  itemCount: course!.topics.length, 
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopicPdfViewer(
                              url: course!.topics[index].nameFile,
                              title: course!.topics[index].name,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        // ignore: prefer_interpolation_to_compose_strings
                        title: Text((index + 1).toString() + '. '+ course!.topics[index].name),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
