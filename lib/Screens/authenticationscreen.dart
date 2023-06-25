import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajar/Screens/teacher_registerscreen.dart';
import '../Functions/auth.dart';
import '../Functions/colors.dart';
import '../Widgets/Buttons.dart';
import '../Widgets/TextfieldForm.dart';
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  bool loading = false;
  bool signup =false;
  GlobalKey<FormState> signinform = GlobalKey();
  GlobalKey<FormState> signupform = GlobalKey();
  String email = "";
  String password = "";
  String sem ="";
  String branch ="";
  String roll="";
  String name ="";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: Palette.textd),
        backgroundColor: Palette.main,
        title: signup?Text("Signup", style: GoogleFonts.signikaNegative(
            fontSize: 23, color: Palette.textd)):Text("SignIn", style: GoogleFonts.signikaNegative(
            fontSize: 23, color: Palette.textd)),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Palette.bgl),
        child:SingleChildScrollView(
          child: signup?Container(
          child: Column(children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Palette.textl,borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: signupform,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10,),
                          TextFieldForm(
                              obscuretext:false,
                              hintText:"Name" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty) {
                                  return 'Please enter a valid Name';
                                }  else {
                                  name = input;
                                }
                                return null;
                              }),
                          SizedBox(height: 10,),
                          TextFieldForm(
                              obscuretext:false,
                              hintText:"Email" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty|| input.contains("@")==false) {
                                  return 'Please enter a valid Email';
                                }  else {
                                  email = input;
                                }
                                return null;
                              }),
                          SizedBox(height: 10,),
                          TextFieldForm(
                              obscuretext: true,
                              hintText:"Password" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty || input.length<5) {
                                  return 'Please enter a valid password';
                                } else {
                                  password = input;
                                }
                                return null;
                              }),
                          SizedBox(height: 10,),
                          TextFieldForm(
                              hintText:"Semester" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty ) {
                                  return 'Please enter the Semester';
                                } else {
                                  sem = input;
                                }
                                return null;
                              }),
                          SizedBox(height: 10,),
                          TextFieldForm(
                              hintText:"Branch" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty ) {
                                  return 'Please enter the branch';
                                } else {
                                  branch = input;
                                }
                                return null;
                              }),
                          SizedBox(height: 10,),
                          TextFieldForm(
                              hintText:"Roll no" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty ) {
                                  return 'Please enter the Rollno';
                                } else {
                                  roll = input;
                                }
                                return null;
                              }),

                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              // ButtonText(text: "Back", onTap: (){ Navigator.of(context).pop();}),
                              SizedBox(width: 10,),
                              loading?CircularProgressIndicator(color: Palette.main,):ButtonBold(onTap: () async {
                                if (signupform.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  //await Authentication().signIn(email, password, context);
                                  if(mounted) {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                  await Register().signUpStudent(email, password, context, name:name, sem:sem, rollno:roll, branch:branch);
                                  signupform.currentState?.reset();
                                }
                              }, text: signup?"Sign Up":"Sign In"),
                              SizedBox(width: 20,),

                            ],

                          ),
                          SizedBox(height: 20,),
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Container(height: 1,)),
                        signup?Text(
                          "Already a Member",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 23,
                            color: Palette.textd,
                          ),
                        ):Text(
                          "New Here then",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 23,
                            color: Palette.textd,
                          ),
                        ),
                        !signup ? ButtonText(text:"Sign Up." , onTap: (){
                          setState(() {
                            signup = !signup;
                          });
                        }):ButtonText(text:"Sign In." , onTap: (){
                          setState(() {
                            signup = !signup;
                          });
                        }),
                        Expanded(child: Container(height: 1,)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(height: 1,)),
                        Text(
                          " If you are a new teacher",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 23,
                            color: Palette.textd,
                          ),
                        ),
                        ButtonText(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const TeacherRegisterScreen()));
                            },
                            text: "Register"),
                        Expanded(child: Container(height: 1,)),

                      ],
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(height: 40,),
          ],),
        ):Container(
          child: Column(children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Palette.textl,borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: signinform,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10,),
                          TextFieldForm(
                              obscuretext:false,
                              hintText:"Email" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty|| input.contains("@")==false) {
                                  return 'Please enter a valid Email';
                                }  else {
                                  email = input;
                                }
                                return null;
                              }),
                          SizedBox(height: 10,),
                          TextFieldForm(
                              obscuretext: true,
                              hintText:"Password" ,
                              validatefunction:(input) {
                                if (input == null || input.isEmpty || input.length<5) {
                                  return 'Please enter a valid password';
                                } else {
                                  password = input;
                                }
                                return null;
                              }),

                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              // ButtonText(text: "Back", onTap: (){ Navigator.of(context).pop();}),
                              SizedBox(width: 10,),
                              loading?CircularProgressIndicator(color: Palette.main,):ButtonBold(onTap: () async {
                                if (signinform.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  await Authentication().signIn(email, password, context);
                                  if(mounted) {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                  // await Register().signUpDriver(email, password, context, name, phno);
                                  signinform.currentState?.reset();
                                  // await Authentication().signIn(email, password, context);

                                }
                              }, text: "Sign In"),
                              SizedBox(width: 20,),

                            ],

                          ),
                          SizedBox(height: 20,),
                        ],
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Container(height: 1,)),
                        signup?Text(
                          "Already a Member",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 23,
                            color: Palette.textd,
                          ),
                        ):Text(
                          "New Here then",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 23,
                            color: Palette.textd,
                          ),
                        ),
                        !signup ? ButtonText(text:"Sign Up." , onTap: (){
                          setState(() {
                            signup = !signup;
                          });
                        }):ButtonText(text:"Sign In." , onTap: (){
                          setState(() {
                            signup = !signup;
                          });
                        }),
                        Expanded(child: Container(height: 1,)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(height: 1,)),
                        Text(
                          " If you are a new teacher",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 23,
                            color: Palette.textd,
                          ),
                        ),
                        ButtonText(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const TeacherRegisterScreen()));
                            },
                            text: "Register"),
                        Expanded(child: Container(height: 1,)),

                      ],
                    ),
                  ],
                ),
              ),
            ),



            SizedBox(height: 40,),
          ],),
        ), )


      ),
    );
  }
}
