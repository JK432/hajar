import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/colors.dart';
import 'package:hajar/Models/AttendanceModel.dart';

import '../Functions/crud.dart';
import '../Widgets/studentcard.dart';
class AttendanceDetailsCard extends StatefulWidget {
  final Attendance attendance;
  const AttendanceDetailsCard({Key? key, required this.attendance}) : super(key: key);

  @override
  State<AttendanceDetailsCard> createState() => _AttendanceDetailsCardState();
}

class _AttendanceDetailsCardState extends State<AttendanceDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgl,
      appBar:AppBar(
        title: Text("Attendance list",
            style: GoogleFonts.signikaNegative(
                fontSize: 25, color: Palette.textd)),
        backgroundColor: Palette.main,
        iconTheme: IconThemeData(color: Palette.textd),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              elementtolist(widget.attendance.absent,false)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              elementtolist(widget.attendance.present,true)),
        ],),
      ),
    );
  }

  Widget builditem(String sid,bool present) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
        child: Studentcard(
          present: present,
          sid: sid,
        ));
  }

  List<Widget> elementtolist(List<String> list,bool present) {
    List<Widget> list1 = [];
    list.forEach((element) {
      list1.add(builditem(element,present));
    });
    return list1;
  }
}
