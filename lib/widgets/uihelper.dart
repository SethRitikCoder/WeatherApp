
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Uihelper {
  static Widget customText({
    required String data,
    required double size,
    Color? color,
    FontWeight? weight,
    String? family,
  }) {
    return Text(
      data,
      style: TextStyle(
        fontSize: size,
        color: color ?? Colors.white,
        fontWeight: weight ?? FontWeight.w300,
        fontFamily: family ?? "Roboto",
      ),
    );
  }

  static Widget custombutton({
    required String buttonName,
    required VoidCallback callback,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(100, 45),
        foregroundColor: Colors.white,
        alignment: Alignment.center,
        backgroundColor: Colors.orange.shade700,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () {
        callback();
      },
      child: Text(
        buttonName,
        style: GoogleFonts.poppins(
          //   fontFamily: GoogleFonts.poppins.,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
  // class Widget customAnimatedText(){
  //   return AnimatedTextKit(animatedTexts: [

  //   ]);
  // }
}
