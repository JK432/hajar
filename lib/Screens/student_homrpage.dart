

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/auth.dart';
import 'package:hajar/Functions/colors.dart';
import 'package:hajar/Widgets/Buttons.dart';

import '../Functions/crud.dart';
import '../Models/CourseModel.dart';
import '../Models/UserModels.dart';
import '../Widgets/alerts.dart';
import '../Widgets/coursecard.dart';
class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}
Student student = Student(courseid: []);
class _StudentHomePageState extends State<StudentHomePage> {

  @override
  callopt() async {
    student = await Crud().readOneStudent(Authentication().userData().uid) ;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    callopt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){AddcourseStudent(context);},child: Icon(Icons.add,size: 40,color: Palette.textd,),backgroundColor: Palette.main),
      appBar: AppBar( title: Text("Hai " + student.name,
          style: GoogleFonts.signikaNegative(
              fontSize:26, color: Palette.textd)) ,
        backgroundColor: Palette.main,
        actions: [
          IconButton(onPressed: (){  Authentication().signOut(context);}, icon:Icon(Icons.logout,color: Palette.textd,) )
        ],
      ),
      backgroundColor: Palette.bgl,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              child: StreamBuilder<List<Course>>(
                stream: Crud().readCoursestudents(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.error);
                    final course = snapshot.data;
                    if (course == null || course.isEmpty) {
                      return Center(
                        child: Container(
                          child: Center(
                              child: Text("Sorry! No docs till now.",
                                  style: GoogleFonts.signikaNegative(
                                      fontSize: 30.0, color: Palette.textd))),
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: course.map(buildGridItem).toList()
                        ),
                      );
                    }
                  }

                  if (snapshot.hasError) {
                    print(snapshot.error);
                    print(snapshot.stackTrace);
                    return const Center(
                      child: CircularProgressIndicator(color: Palette.alert),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Palette.main),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }

  Widget buildGridItem(Course course) {
    if(course.students.contains(Authentication().userData().uid)){
      return Padding(
          padding: const EdgeInsets.only(top: 15.0,left: 8.0,right: 8.0),
          child: CourseCard(course:course ,student: true,)
      );
    }
    else return Container();

  }
}
