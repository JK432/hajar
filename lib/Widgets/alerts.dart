import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Functions/auth.dart';
import 'package:hajar/Models/CourseModel.dart';
import '../Functions/colors.dart';
import '../Functions/crud.dart';
import 'Buttons.dart';
import 'Snackbar.dart';
import 'TextfieldForm.dart';


///Alert for adding Course Teacher
AddcourseTeacher(BuildContext context) {

  GlobalKey<FormState> addcourseform = GlobalKey();
  String name = "";
  String sem = "";
  String branch="";
  AlertDialog alert = AlertDialog(


    backgroundColor: Palette.bgl,
    title:  Text("Add Course",style: GoogleFonts.signikaNegative(
        fontSize: 23.0, color: Palette.textd),),
    content: Container(
      child:  Form(
          key: addcourseform,
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextFieldForm(
                  validatefunction: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter the Name';
                    } else {
                      name = input;
                    }
                    return null;
                  },
                  hintText: "Name"),
              SizedBox(height: 10,),
              TextFieldForm(
                  validatefunction: (input) {
                    if (input == null ||
                        input.isEmpty ) {
                      return 'Please enter the semester';
                    } else {
                      sem = input;
                    }
                    return null;
                  },
                  hintText: "Semester"),
              SizedBox(height: 10,),
              TextFieldForm(
                  validatefunction: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter the Branch';
                    } else {
                      branch = input;
                    }
                    return null;
                  },
                  hintText: "Branch"),
              SizedBox(height: 10,),
            ],
          )),
    ),
    actions: [
      ButtonText(text: "Cancel", onTap: (){  Navigator.of(context).pop();}),
      ButtonBold(onTap: (){
        if(addcourseform.currentState!.validate()){

          Course coursedata = Course(students: [],teacherid:Authentication().userData().uid ,sem:sem ,branch:branch ,id:"",name:name ,);
          Crud().AddCourse(coursedata, context).then((value) {Navigator.of(context).pop();});

        }
        },

          text: "Add Course"),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


///Alert for adding course student
AddcourseStudent(BuildContext context) {

  GlobalKey<FormState> addstudentcourseform = GlobalKey();
  String id = "";

  AlertDialog alert = AlertDialog(


    backgroundColor: Palette.bgl,
    title:  Text("Add Course",style: GoogleFonts.signikaNegative(
        fontSize: 23.0, color: Palette.textd),),
    content: Container(
      child:  Form(
          key: addstudentcourseform,
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextFieldForm(
                  validatefunction: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter the Id';
                    } else {
                      id = input;
                    }
                    return null;
                  },
                  hintText: "Course ID"),

            ],
          )),
    ),
    actions: [
      ButtonText(text: "Cancel", onTap: (){  Navigator.of(context).pop();}),
      ButtonBold(onTap: (){
        if(addstudentcourseform.currentState!.validate()){
          Crud().AddStudentCourse(id,context);
          Navigator.of(context).pop();


        }
      },

          text: "Continue"),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}