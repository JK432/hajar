import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/auth.dart';
import 'package:hajar/Models/AttendanceModel.dart';

import '../Functions/colors.dart';
import '../Screens/teacher_attendancedetailsScreen.dart';
class AttendanceCard extends StatefulWidget {
  final Attendance attendance;
  final bool student;
  const AttendanceCard({Key? key, required this.attendance, required this.student}) : super(key: key);

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.student?(){}:(){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AttendanceDetailsCard(attendance: widget.attendance,)));
      },
      child: Container(
        decoration: BoxDecoration(color: Palette.textl,borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 10,right: 8.0,bottom: 8.0),
          child: Column(children: [
            Row(children: [
              Icon(Icons.calendar_month,color: Palette.textd,),SizedBox(width: 5,),
              Text(widget.attendance.date+" . "+widget.attendance.time,
                  style: GoogleFonts.signikaNegative(
                      fontSize: 26, color: Palette.textd,fontWeight: FontWeight.bold)),
            ],),
            !widget.student?Row(children: [
              Icon(Icons.done,color: Palette.sucess,),SizedBox(width: 5,),
              Text(widget.attendance.present.length.toString(),
                  style: GoogleFonts.signikaNegative(
                      fontSize: 20, color: Palette.sucess,)),
              SizedBox(width: 20,),
              Icon(Icons.close,color: Palette.alert,),SizedBox(width: 5,),
              Text(widget.attendance.absent.length.toString(),
                  style: GoogleFonts.signikaNegative(
                    fontSize: 20, color: Palette.alert,)),
            ],):Row(children: [
              widget.attendance.present.contains(Authentication().userData().uid)?Row(
                children: [ Icon(Icons.done,color: Palette.sucess,),SizedBox(width: 5,),
                  Text("Present".toString(),
                      style: GoogleFonts.signikaNegative(
                        fontSize: 20, color: Palette.sucess,)),],
              ):Container(),
              widget.attendance.absent.contains(Authentication().userData().uid)?Row(
                children: [

                  Icon(Icons.close,color: Palette.alert,),SizedBox(width: 5,),
                  Text("Absent".toString(),
                      style: GoogleFonts.signikaNegative(
                        fontSize: 20, color: Palette.alert,)),

                ],
              ):Container(),
            ],),
            SizedBox(height: 5,)

          ],),
        ),
      ),
    );
  }
}
