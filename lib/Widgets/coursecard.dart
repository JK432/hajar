import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/colors.dart';
import 'package:hajar/Functions/crud.dart';
import 'package:hajar/Models/CourseModel.dart';

import '../Screens/student_attendance_screen.dart';
import '../Screens/teacher_attendancescreen.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  final bool student;
  const CourseCard({Key? key, required this.course, required this.student}) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.student?(){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StudentsAttendanceDetils(course: widget.course,)));

       }:(){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              AttendanceScreen(course: widget.course,)));},
      child: Container(
        decoration: BoxDecoration(
            color: Palette.textl, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height:5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.book,
                      color: Palette.textd,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.course.name,
                      style: GoogleFonts.signikaNegative(
                          fontSize: 30.0, color: Palette.textd,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Palette.textd,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    FutureBuilder(
                        future: Crud().readOneTeacher(widget.course.teacherid),
                        builder: (context, snapshot) {
                          if (snapshot != null && snapshot.hasData) {
                            return Text(
                              snapshot.data!.name,
                              style: GoogleFonts.signikaNegative(
                                  fontSize: 18,
                                  color: Palette.textd,
                                  height: 0.99),
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: Palette.textd,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      widget.course.sem + "." + widget.course.branch,
                      style: GoogleFonts.signikaNegative(
                          fontSize: 18.0, color: Palette.textd),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.numbers,
                      color: Palette.textd,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${widget.course.students.length}",
                      style: GoogleFonts.signikaNegative(
                          fontSize: 18.0, color: Palette.textd),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                widget.student?Container():Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Palette.textd,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${widget.course.id}",
                      style: GoogleFonts.signikaNegative(
                          fontSize: 18.0, color: Palette.textd),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ]),
        ),
      ),
    );
  }
}
