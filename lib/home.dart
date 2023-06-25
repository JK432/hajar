import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Screens/authenticationscreen.dart';
import 'dash.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print(FirebaseAuth.instance.currentUser);
            if(snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData) {
              return Dash();
            } else if(snapshot.hasError) {
              return Center(child: Text("Some thing went wrong",style: TextStyle(color: Colors.white),),);
            } else {
              return AuthenticationScreen();
            }
          }
      ) ,
    );
  }
}
