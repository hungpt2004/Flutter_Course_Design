import 'package:flutter/cupertino.dart';
import 'package:flutter_travel_booking/theme/text/font_family.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleCustom{
  textStyleForm (double size,FontWeight weight, Color color) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color
    );
  }
  textStyleMembership(double size,FontWeight weight, Color color, String member) {

  }
}