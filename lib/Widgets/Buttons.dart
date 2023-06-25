import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions/colors.dart';


class ButtonBold extends StatefulWidget {
  final String text;
  final void Function() onTap;
  const ButtonBold({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  State<ButtonBold> createState() => _ButtonBoldState();
}

class _ButtonBoldState extends State<ButtonBold> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onTap,
      child:Container(

        decoration: BoxDecoration(color: Palette.main,borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.only(top: 2,bottom: 2,left: 8.0,right: 8.0),
          child: Text(widget.text,style: GoogleFonts.signikaNegative(
              fontSize: 25.0, color: Palette.textd),),
        ),
      ),);
  }
}


class ButtonText extends StatefulWidget {
  final String text;
  final void Function() onTap;
  const ButtonText({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  State<ButtonText> createState() => _ButtonTextState();
}

class _ButtonTextState extends State<ButtonText> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:widget.onTap , child: Text(widget.text,style: GoogleFonts.signikaNegative(
        fontSize: 23.0, color: Palette.main),));
  }
}

class ButtonLarge extends StatefulWidget {
  final String text;
  final void Function() onTap;
  const ButtonLarge({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  State<ButtonLarge> createState() => _ButtonLargeState();
}

class _ButtonLargeState extends State<ButtonLarge> {
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:widget.onTap,child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Palette.main),

      height: 100,
      width: MediaQuery.of(context).size.width-100,
      child:     Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(widget.text,style: GoogleFonts.signikaNegative(
              fontSize: 60.0, color: Palette.textd,fontWeight: FontWeight.bold),),
        ),
      ),
    ),);
    // return TextButton(onPressed:widget.onTap , child:

    //
    //
    //     );
  }
}