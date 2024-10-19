import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../constant/constant.dart';

//SHOW MESSAGE DIALOG
void showMessageDialog(BuildContext context, String message, bool status) {
  Flushbar(
    messageText: Row(
      children: [
        Icon(
          status ? Icons.check : Icons.clear,
          color: status ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          message,
          style: const TextStyle(
            fontSize: 15, // Kích thước font chữ
            fontWeight: FontWeight.w600, // Kiểu chữ đậm
            color: Colors.black, // Màu chữ
            fontFamily: textFontContent, // Font chữ tùy chỉnh
          ),
        ),
      ],
    ),
    boxShadows: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.8),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3)),
    ],
    duration: Duration(seconds: 3),
    backgroundColor: Colors.white60,
    // Màu nền của Toast
    margin: EdgeInsets.all(8),
    // Lề của Toast
    borderRadius: BorderRadius.circular(8), // Bo góc cho Toast
  ).show(context);
}

//CONVERT FOMART DATE
String formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat('EEEE, dd MMMM yyyy').format(parsedDate);
}

//DIALOG SHARE
void showDialogShareLink(BuildContext context, String url, bool isShare){
  TextEditingController controller = TextEditingController();
  controller.text = url;
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Link news"),
      content: Container(
        width: 60,
        height: 60,
        child: TextField(
          readOnly: true,
          textAlign: TextAlign.center,
          maxLines: 1, // Single line to enable horizontal scrolling
          decoration: InputDecoration(
            hintText: controller.text,
            hintStyle: const TextStyle(
                fontFamily: textFontContent,
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),
            suffixIcon: IconButton(
              onPressed: () {
                try {
                  Clipboard.setData(ClipboardData(text: controller.text));
                  showMessageDialog(context, "Copied Link", true);
                } catch (e) {
                  showMessageDialog(context, "Clip board unavailable", false);
                }
              },
              icon: const Icon(Icons.copy),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          style: const TextStyle(overflow: TextOverflow.ellipsis), // Display ellipsis if text is too long
          scrollPadding: EdgeInsets.zero,
          scrollPhysics: const BouncingScrollPhysics(), // For smoother scrolling
          textInputAction: TextInputAction.none,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            isShare = !isShare;
            Navigator.pop(context);
          },
          child: const Text("Done"),
        )
      ],
    ),
  );
}

