import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hajar/Functions/auth.dart';
import 'package:hajar/Models/AttendanceModel.dart';
import 'package:hajar/Models/CourseModel.dart';
import '../Models/UserModels.dart';
import '../Widgets/Snackbar.dart';

class Crud{

  ///read single teacher
  Future<Teacher> readOneTeacher(String id) async {
    Teacher teacher = Teacher();
    final snapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(id).get();
    teacher = Teacher.fromJson(snapshot.data()!);
    return teacher;
  }


  ///read single student
  Future<Student> readOneStudent(String id) async {
    Student student = Student(courseid: []);
    final snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(id).get();
    student = Student.fromJson(snapshot.data()!);
    return student;
  }

///read single course
  Future<Course> readOneCourse(String id,context) async {
    Course course = Course(students: []);
    final snapshot = await FirebaseFirestore.instance
        .collection('course')
        .doc(id).get();
    try{
      course = Course.fromJson(snapshot.data()!);
    }catch(e){

      ScaffoldMessenger.of(context)
          .showSnackBar(snackbar().snackBarFail("Can't find the Course"));
    }

    return course;
  }


  ///Addcourse
  AddCourse( Course coursedata ,BuildContext context)async{
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Course course= Course(students:[] ,name:coursedata.name ,id:id,branch:coursedata.branch ,sem:coursedata.sem,teacherid:coursedata.teacherid );
    try{
      final FSinstance = FirebaseFirestore.instance
          .collection("course")
          .doc(id);
      final json = course.toJson();
      await FSinstance.set(json).then((value) => {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarSucess("Course Added"))
      });
    }on FirebaseException catch(e){
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail("Error"));
      }

    }
  }

///Addcourse for student
  AddStudentCourse( String id ,BuildContext context)async{
Course coursedata = Course(students: []);
List<String> students =[];
     try{
       coursedata = await readOneCourse(id,context);
       if(coursedata.students.contains(Authentication().userData().uid)){
         ScaffoldMessenger.of(context)
             .showSnackBar(snackbar().snackBarFail("Already registered"));
       }else{
         students = coursedata.students;
         students.add(Authentication().userData().uid);
       }

       coursedata = Course(students: students,name:coursedata.name ,id:coursedata.id ,branch:coursedata.branch ,sem:coursedata.sem ,teacherid: coursedata.teacherid,);
       final Finstance = FirebaseFirestore.instance.collection("course").doc(id);
       final json = coursedata.toJson();
       await Finstance.update(json).then((value) => null);

    }on FirebaseException catch(e){
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail("Error"));
      }

    }
  }

  ///Add attendance Teacher
  Addattendance( String cid, Attendance attendancedata ,BuildContext context)async{
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Attendance attendance = Attendance(present: attendancedata.present, absent: attendancedata.absent,id:id ,date:attendancedata.date ,time: attendancedata.time);
    try{
      final FSinstance = FirebaseFirestore.instance
          .collection("course")
          .doc(cid).collection("attendance").doc(id);
      final json = attendance.toJson();
      await FSinstance.set(json).then((value) => {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarSucess("Attendance Added"))
      });
    }on FirebaseException catch(e){
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail("Error"));
      }

    }
  }
  ///StreamCourseforteacher
  Stream<List<Course>> readCourse() => FirebaseFirestore.instance
      .collection('course')
      .where('teacherid',isEqualTo: Authentication().userData().uid)
      .snapshots()
      .map((snaphot) =>
      snaphot.docs.map((doc) => Course.fromJson(doc.data())).toList());


  ///StreamCoursefortudents
  Stream<List<Course>> readCoursestudents() => FirebaseFirestore.instance
      .collection('course').orderBy('id',descending: true)
      .snapshots()
      .map((snaphot) =>
      snaphot.docs.map((doc) => Course.fromJson(doc.data())).toList());

  ///Stream Single course
  Stream<Course> stidentsincourse(String id) =>
      FirebaseFirestore.instance
          .collection('course')
          .doc(id).snapshots().map((snapshot) => Course.fromJson(snapshot.data()!));

  ///Stream attendance
  Stream<List<Attendance>> readAttendance(String cid) => FirebaseFirestore.instance
      .collection('course').doc(cid).collection('attendance')
      .snapshots()
      .map((snaphot) =>
      snaphot.docs.map((doc) => Attendance.fromJson(doc.data())).toList());
}
