import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/UserModels.dart';
import '../Widgets/Snackbar.dart';





class Authentication{

  signIn(String email, String password, BuildContext context) async {
    print(email);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) =>
      {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarSucess("Signed In"))
      });

    } on FirebaseAuthException catch (e) {
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarFail("Error"));
      }
    } catch (e) {
      print(e);
    }
  }


  ///SIGNOUT
  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
          snackbar().snackBarSucess("Signed Out"));
    } on FirebaseAuthException catch (e) {
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarFail("Error"));
      }
    } catch (e) {
      print(e);
    }
  }





  GenaralUser userData() {
    String? e = FirebaseAuth.instance.currentUser?.email;
    String? u = FirebaseAuth.instance.currentUser?.uid;
    GenaralUser U = GenaralUser( e == null ? "" : e, u == null ? "" : u);
    return U;
  }


  Stream<Uuser> readUser() {
    String uid = Authentication()
        .userData()
        .uid;
    print(uid);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => Uuser.fromJson(snapshot.data() as Map<String, dynamic>));
  }


  signUpStudent(
      String email, String password, BuildContext context,
      {required name,
        required sem,
        required rollno,
        required branch}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value != null && value.user != null) {
          User user = value.user!;
          Student student = Student(name: name,sem: sem,rollno: rollno,branch: branch,email: email,id: user.uid, courseid: []);
          await CreateStudentAcc(student, user);
        }
      }).then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarSucess("Student registered"))
      });

    } on FirebaseAuthException catch (e) {
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail("Error"));
      }
    } catch (e) {
      print(e);
    }
  }

  CreateStudentAcc(Student student, User user) async {
    final FSinstance =
    FirebaseFirestore.instance.collection("users").doc(user.uid);
    Uuser uuser = Uuser(uid: user.uid, roll: "student");
    final json = uuser.toJson();
    await FSinstance.set(json).then((value) => null);

    final FSdriverinstance =
    FirebaseFirestore.instance.collection("students").doc(user.uid);

    final djson = student.toJson();
    await FSdriverinstance.set(djson).then((value) => null);
  }

}
class Register{

  signUpStudent(
      String email, String password, BuildContext context,
      {required name,
        required sem,
        required rollno,
        required branch}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value != null && value.user != null) {
          User user = value.user!;
          Student student = Student(name: name,sem: sem,rollno: rollno,branch: branch,email: email,id: user.uid, courseid: []);
          await CreateStudentAcc(student, user);
        }
      }).then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarSucess("Student registered"))
      });
    } on FirebaseAuthException catch (e) {
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail("Error"));
      }
    } catch (e) {
      print(e);
    }
  }

  CreateStudentAcc(Student student, User user) async {
    final FSinstance =
    FirebaseFirestore.instance.collection("users").doc(user.uid);
    Uuser uuser = Uuser(uid: user.uid, roll: "student");
    final json = uuser.toJson();
    await FSinstance.set(json).then((value) => null);

    final FSdriverinstance =
    FirebaseFirestore.instance.collection("students").doc(user.uid);

    final djson = student.toJson();
    await FSdriverinstance.set(djson).then((value) => null);
  }




  signUpTeacher(
      {required name,
      required email, required password, required context
      }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value != null && value.user != null) {
          User user = value.user!;
          Teacher teacher = Teacher(email:email ,id:user.uid ,name: name,);
          await CreateTeacherAcc(teacher, user);
        }
      }).then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar().snackBarSucess("Registered"))
      });
    } on FirebaseAuthException catch (e) {
      String msg = e.message!;
      if (msg != null)
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail(msg));
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar().snackBarFail("Error"));
      }
    } catch (e) {
      print(e);
    }
  }




  CreateTeacherAcc(Teacher teacher, User user) async {
    final FSinstance =
    FirebaseFirestore.instance.collection("users").doc(user.uid);
    Uuser uuser = Uuser(uid: user.uid, roll: "teacher");
    final json = uuser.toJson();
    await FSinstance.set(json).then((value) => null);

    final FSdriverinstance =
    FirebaseFirestore.instance.collection("teachers").doc(user.uid);

    final djson = teacher.toJson();
    await FSdriverinstance.set(djson).then((value) => null);
  }





}





