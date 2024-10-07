import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app_flutter/constants/constant_value.dart';
import 'package:todolist_app_flutter/models/task.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final DateTime taskCreatedAt;

  const TaskTile({
    Key? key,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskCreatedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        color: primaryColors, // You can use your defined primary color here
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: contentFont, color: fiveColors),
              ),
              SizedBox(height: 8.0),
              Text(
                taskDescription,
                style: TextStyle(fontSize: 14, fontFamily: contentFont, fontWeight: FontWeight.w600,color: fiveColors),
              ),
              SizedBox(height: 8.0),
              Text(
                'Created at: ${_formatDate(taskCreatedAt.toLocal().toString().split(' ')[0])}',
                style: TextStyle(fontSize: 10, fontFamily: contentFont, fontWeight: FontWeight.w600,color: fiveColors),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy').format(parsedDate);
  }
}
