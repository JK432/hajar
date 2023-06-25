import 'package:flutter/material.dart';
import 'package:hajar/Screens/teacher_homepage.dart';

import 'Functions/auth.dart';
import 'Functions/colors.dart';
import 'Models/UserModels.dart';
import 'Screens/student_homrpage.dart';
import 'Widgets/Buttons.dart';
class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.bgd,
        body: StreamBuilder<Uuser>(
          stream: Authentication().readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final bus = snapshot.data;
              if (bus == null ) {
                return  Center(child: Text("Error"));
              } else {
                if(bus.roll=='teacher'){
                  return TeacherHomePage();
                }
                if(bus.roll=='student'){
                  return StudentHomePage();
                }
              }
            }

            if (snapshot.hasError) {
              return  Center(child: ButtonBold(onTap: ()async {

                await Authentication().signOut(context);
              }, text: "LogOut"),);
            }
            else {
              return const Center(
                child: CircularProgressIndicator(color: Palette.main),
              );
            }
          },
        )
    );
  }
}
