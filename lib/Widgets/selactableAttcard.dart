import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Functions/colors.dart';
import '../Functions/crud.dart';

class selectableStudentAttcard extends StatefulWidget {
  final String sid;

  final ValueChanged<bool> onChanged;
   selectableStudentAttcard({Key? key, required this.sid, required this.onChanged})
      : super(key: key);

  @override
  State<selectableStudentAttcard> createState() =>
      _selectableStudentAttcardState();
}

class _selectableStudentAttcardState extends State<selectableStudentAttcard> {
  @override
  bool checked = true;
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: Palette.textl, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Checkbox(
                value: checked,
                onChanged: (value) {
                  if(value!=null) {
                    checked = value;
                    widget.onChanged(value);
                  }

                  setState(() {});
                },focusColor: Palette.main,activeColor: Palette.main,),
            SizedBox(
              width: 10,
            ),
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
                              width: 5,
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
                          children: [],
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
