import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/colors.dart';
import 'package:hajar/Models/CourseModel.dart';
import 'package:hajar/Models/UserModels.dart';

import '../Functions/auth.dart';
import '../Functions/crud.dart';
import '../Widgets/Buttons.dart';
import '../Widgets/alerts.dart';
import '../Widgets/coursecard.dart';
class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);


  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}
Teacher teacher = Teacher();
class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  callopt() async {
    teacher = await Crud().readOneTeacher(Authentication().userData().uid) ;
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
      floatingActionButton: FloatingActionButton(onPressed: (){AddcourseTeacher(context);},child: Icon(Icons.add,color: Palette.textd,size:40 ),backgroundColor: Palette.main,),
      appBar: AppBar( title: Text("Hai " + teacher.name,
          style: GoogleFonts.signikaNegative(
              fontSize:26, color: Palette.textd)) ,
        backgroundColor: Palette.main,
        actions: [
          IconButton(onPressed: (){  Authentication().signOut(context);}, icon:Icon(Icons.logout,color: Palette.textd,) )
        ],
      ),
      backgroundColor: Palette.bgl,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Container(
                child: StreamBuilder<List<Course>>(
                  stream: Crud().readCourse(),
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
                            //
                            // [
                            //   Container(
                            //     width: MediaQuery.of(context).size.width,
                            //
                            //     child: ListView(
                            //       scrollDirection: Axis.horizontal,
                            //       children: course.map(buildGridItem).toList(),
                            //     ),
                            //   ),
                            //   SizedBox(
                            //     height: 10,
                            //   )
                            // ],
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
      )
    );
  }

  Widget buildGridItem(Course course) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10.0),
      child: CourseCard(course:course,student: false,)
    );
  }
}
