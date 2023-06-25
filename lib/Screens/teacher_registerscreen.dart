import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Functions/auth.dart';
import '../Functions/colors.dart';
import '../Widgets/Buttons.dart';
import '../Widgets/TextfieldForm.dart';
class TeacherRegisterScreen extends StatefulWidget {
  const TeacherRegisterScreen({Key? key}) : super(key: key);

  @override
  State<TeacherRegisterScreen> createState() => _TeacherRegisterScreenState();
}

class _TeacherRegisterScreenState extends State<TeacherRegisterScreen> {
  @override
  bool loading = false;
  bool signup =false;

  String email = "";
  String password = "";
  String name ="";

  final GlobalKey<FormState> teachersignupform = GlobalKey();
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: Palette.textd),
        backgroundColor: Palette.main,
        title: Text("Register", style: GoogleFonts.signikaNegative(
            fontSize: 23, color: Palette.textd)),

      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Palette.bgl),
          child:SingleChildScrollView(
            child: Container(
              child: Column(children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Palette.textl,borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                          key: teachersignupform,
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

                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  ButtonText(text: "Back", onTap: (){ Navigator.of(context).pop();}),
                                  SizedBox(width: 10,),
                                  loading?CircularProgressIndicator():ButtonBold(onTap: () async {
                                    if (teachersignupform.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      //await Authentication().signIn(email, password, context);
                                      await Register().signUpTeacher(name:name ,email:email ,context:context ,password:password ,);
                                      if(mounted) {
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                      teachersignupform.currentState?.reset();
                                       Navigator.of(context).pop();

                                    }
                                  }, text: "Register"),
                                  SizedBox(width: 20,),

                                ],

                              ),
                              SizedBox(height: 20,),
                            ],
                          )),
                    ),
                  ),
                ),


                SizedBox(height: 40,),
              ],),
            ),
          )


      ),
    );
  }
}
