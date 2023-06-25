import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Models/CourseModel.dart';
import 'package:hajar/Screens/teacher_addAttendance.dart';

import '../Functions/colors.dart';
import '../Functions/crud.dart';
import '../Models/AttendanceModel.dart';
import '../Widgets/Attendancecard.dart';
class StudentsAttendanceDetils extends StatefulWidget {
  final Course course;
  const StudentsAttendanceDetils({Key? key, required this.course}) : super(key: key);

  @override
  State<StudentsAttendanceDetils> createState() => _StudentsAttendanceDetilsState();
}

class _StudentsAttendanceDetilsState extends State<StudentsAttendanceDetils> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance",
            style: GoogleFonts.signikaNegative(
                fontSize: 25, color: Palette.textd)),
        backgroundColor: Palette.main,
        iconTheme: IconThemeData(color: Palette.textd),
      ),
      backgroundColor: Palette.bgl,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: StreamBuilder<List<Attendance>>(
                  stream: Crud().readAttendance(widget.course.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.error);
                      final attendance = snapshot.data;
                      if (attendance == null || attendance.isEmpty) {
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
                              children: attendance.map(buildGridItem).toList()),
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
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(Attendance attendance) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: AttendanceCard(
          student: true,
          attendance: attendance,
        ));
  }
}
