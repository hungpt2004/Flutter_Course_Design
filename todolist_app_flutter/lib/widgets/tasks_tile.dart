import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app_flutter/constants/constant_value.dart';
import 'package:todolist_app_flutter/models/task.dart';
import 'package:todolist_app_flutter/screens/tasks_detail_screen.dart';
import 'package:todolist_app_flutter/widgets/slider_page_route.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, SlidePageRoute(page: TasksDetailScreen(task: widget.task), beginOffset: const Offset(1,0), endOffset: Offset.zero, duration: const Duration(milliseconds: 1000)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          color: (widget.task.id % 2 == 0) ? primaryColors : secondColors, // You can use your defined primary color here
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
                  widget.task.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: contentFont, color: fiveColors),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.task.description,
                  style: const TextStyle(fontSize: 14, fontFamily: contentFont, fontWeight: FontWeight.w600,color: fiveColors),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Created at: ${_formatDate(widget.task.createdAt.toLocal().toString().split(' ')[0])}',
                  style: const TextStyle(fontSize: 10, fontFamily: contentFont, fontWeight: FontWeight.w600,color: fiveColors),
                ),
                Text(
                  'Deadline at: ${widget.task.deadlineAt != null ? _formatDate(widget.task.deadlineAt.toLocal().toString().split(' ')[0]) : 'No deadline'}',
                  style: const TextStyle(fontSize: 10, fontFamily: contentFont, fontWeight: FontWeight.w600, color: fiveColors),
                ),
              ],
            ),
          ),
        ),
      )
          .animate()
          .fade(delay: 1200.ms)
          .slideY(begin: 1.0, end: 0, duration: 1500.ms),
    );
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy').format(parsedDate);
  }

}
