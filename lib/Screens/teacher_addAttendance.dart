import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/colors.dart';
import 'package:hajar/Models/AttendanceModel.dart';
import 'package:hajar/Models/CourseModel.dart';
import 'package:hajar/Widgets/Buttons.dart';
import 'package:intl/intl.dart';
import '../Functions/crud.dart';
import '../Models/UserModels.dart';
import '../Widgets/coursecard.dart';
import '../Widgets/selactableAttcard.dart';

class AddAttendanceScreen extends StatefulWidget {

  final Course course;
  const AddAttendanceScreen({Key? key, required this.course}) : super(key: key);

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}
DateTime selectedDate = DateTime.now();
String _setTime="", _setDate="";
String _hour="", _minute="", _time="";
String dateTime="";
TimeOfDay selectedTime = TimeOfDay(hour:DateTime.now().hour,minute:DateTime.now().minute  );
class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  @override
  List<String> presentlist = [];
  List<String> absentlist = [];
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{

       Attendance attendancedata = Attendance(present: presentlist, absent: absentlist,time:"${selectedTime.hour.toString()+":"+selectedTime.minute.toString()}" ,date:"${selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString()}");
        await Crud().Addattendance( widget.course.id, attendancedata ,context);
        Navigator.of(context).pop();
        },child:Icon(Icons.add_chart,color: Palette.textd,size: 26),backgroundColor: Palette.main,),
      backgroundColor: Palette.bgl,
      appBar: AppBar(
          backgroundColor: Palette.main,
          title: Text("Add attendance",
              style: GoogleFonts.signikaNegative(
                  fontSize: 26, color: Palette.textd)),
          iconTheme: IconThemeData(color: Palette.textd)),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: Palette.textd),
                    SizedBox(
                      width: 10,
                    ),
                    ButtonText(text: "${selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString()}", onTap: () {_selectDate(context);})
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Palette.textd),
                    SizedBox(
                      width: 10,
                    ),
                    ButtonText(text: selectedTime.hour.toString() + ":"+selectedTime.minute.toString(), onTap: () {_selectTime(context);})
                  ],
                ),
                Container(
                  child: StreamBuilder<Course>(
                    stream: Crud().stidentsincourse(widget.course.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.error);
                        final course = snapshot.data;
                        if (course == null) {
                          return Center(
                            child: Container(
                              child: Center(
                                  child: Text("Sorry! No docs till now.",
                                      style: GoogleFonts.signikaNegative(
                                          fontSize: 30.0,
                                          color: Palette.textd))),
                            ),
                          );
                        } else {
                          return Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    elementtolist(snapshot.data!.students)),
                          );
                        }
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error);
                        print(snapshot.stackTrace);
                        return const Center(
                          child:
                              CircularProgressIndicator(color: Palette.alert),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Palette.main),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget builditem(String sid) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 0, right: 5.0),
        child: selectableStudentAttcard(
          onChanged: (value) {
            print(value);
            if (value == true) {
              if(!presentlist.contains(sid))
              presentlist.add(sid);
              if (absentlist.contains(sid)) {
                absentlist.remove(sid);
              }
            }
            if (value == false ) {
              if(!absentlist.contains(sid)){absentlist.add(sid);}
              if (presentlist.contains(sid)) {
                presentlist.remove(sid);
              }
            }
            print(presentlist);
            print(absentlist);

          },
          sid: sid,
        ));
  }

  List<Widget> elementtolist(List<String> list) {
    presentlist = list;
    absentlist = [];
    List<Widget> list1 = [];
    list.forEach((element) {
      list1.add(builditem(element));
    });
    return list1;
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(

        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101),


    );
    if (picked != null)
      setState(() {
        selectedDate = picked;

        // _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {

        selectedTime = picked;
      });}

}
