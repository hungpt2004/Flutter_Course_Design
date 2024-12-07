import 'package:flutter/cupertino.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/text/font_family.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TextStyleCustom{

  //TEXT STYLE CUSTOM
  textStyleForm (double size,FontWeight weight, Color color) {
    return GoogleFonts.openSans(
      fontSize: size,
      fontWeight: weight,
      color: color
    );
  }

  textStyleMembership(double size,FontWeight weight, Color color, String member) {

  }

  //DATE FORMAT
  String formatDateFromText(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }


}