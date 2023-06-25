import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Functions/colors.dart';
import '../Functions/crud.dart';

class Studentcard extends StatefulWidget {
  final String sid;
  bool present;
  Studentcard({Key? key, required this.sid, this.present=true,})
      : super(key: key);

  @override
  State<Studentcard> createState() =>
      _StudentcardState();
}

class _StudentcardState extends State<Studentcard> {
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(

          color:Palette.textl, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [

            FutureBuilder(
                future: Crud().readOneStudent(widget.sid),
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Palette.textd,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              snapshot.data!.name,
                              style: GoogleFonts.signikaNegative(
                                  fontSize: 28,
                                  color: Palette.textd,
                                  height: 0.99,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.school,
                              color: Palette.textd,
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              snapshot.data!.sem + "." + snapshot.data!.branch,
                              style: GoogleFonts.signikaNegative(
                                  fontSize: 18,
                                  color: Palette.textd,
                                  height: 0.99),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.numbers,
                              color: Palette.textd,
                              size: 18,
                            ),
                            Text(
                              snapshot.data!.rollno,
                              style: GoogleFonts.signikaNegative(
                                  fontSize: 18,
                                  color: Palette.textd,
                                  height: 0.99),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(widget.present?Icons.done:Icons.close,color:widget.present?Palette.sucess:Palette.alert,),
                            SizedBox(width: 10,),
                            Text(
                              widget.present?"Present":"Absent",
                              style: GoogleFonts.signikaNegative(
                                  fontSize: 18,
                                  color:widget.present?Palette.sucess: Palette.alert,
                                  height: 0.99),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    print(snapshot.error);
                    print(snapshot.stackTrace);
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
