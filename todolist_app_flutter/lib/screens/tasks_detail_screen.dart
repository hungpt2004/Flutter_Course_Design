import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app_flutter/constants/constant_value.dart';
import 'package:todolist_app_flutter/models/task_data.dart';

import '../models/task.dart';

class TasksDetailScreen extends StatefulWidget {
  const TasksDetailScreen({super.key, required this.task});

  final Task task;

  @override
  State<TasksDetailScreen> createState() => _TasksDetailScreenState();
}

class _TasksDetailScreenState extends State<TasksDetailScreen> {
  bool status = false;
  bool statusUpdate = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _deadlineController;

  //INITSTATE
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.name);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _deadlineController =
        TextEditingController(text: _formatDate(widget.task.deadlineAt));
  }

  //DISPOSE
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  //DELETE TASK METHOD
  void _deleteTaskByID(int taskId) {
    final taskData = Provider.of<TaskData>(context, listen: false);
    taskData.removeByID(taskId);
    status = !status;
    if (status) {
      _showMessageToast(context, "Delete success Task [${taskId}]", status);
    } else {
      _showMessageToast(context, "Delete failed Task [${taskId}]", !status);
    }
  }

  //UPDATE TASK METHOD
  void _updateTask(int id) {
    final taskData = Provider.of<TaskData>(context, listen: false);
    String newName = _titleController.text.trim(); // Trim whitespace
    String newDescription =
        _descriptionController.text.trim(); // Trim whitespace
    // Check if the title and description are not empty
    if (newName.isEmpty || newDescription.isEmpty) {
      _showMessageToast(
          context, "Title and description cannot be empty", false);
      return;
    }
    String newDeadline = _deadlineController.text.trim();

    DateTime dateTime = DateFormat('dd MMMM yyyy').parse(newDeadline);

    // Call the update method with the formatted date string
    taskData.updateTask(newName, newDescription, dateTime, id);
    statusUpdate = !statusUpdate;

    if (statusUpdate) {
      _showMessageToast(
          context, "Task [$id] updated successfully!", statusUpdate);
    } else {
      // Handle parsing errors
      _showMessageToast(context, "Error: Invalid date format !", !statusUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _showTimeToast(context, widget.task.createdAt,
                              widget.task.deadlineAt);
                        },
                        child: AssetImage("clock.png", 20, 20),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _showUpdateDialog();
                        },
                        child: AssetImage("edit-2.png", 20, 20),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _showConfirmDeleteToast(context);
                        },
                        child: AssetImage("trash-2.png", 20, 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.task.name,
                        style: const TextStyle(
                            fontFamily: titleFont,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: widget.task.isFavourite
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.task.isFavourite = !widget.task.isFavourite;
                            if(widget.task.isFavourite == true) {
                              _showMessageToast(context, "Add to favourite success", true);
                            } else {
                              _showMessageToast(context, "Remove favourite success", false);
                            }
                          });
                        },
                      )
                    ],
                  ),
                  Text(
                    widget.task.description,
                    style: const TextStyle(
                        fontFamily: contentFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Create at : ${_formatDate(widget.task.createdAt)}", // Directly using the DateTime
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: contentFont,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Deadline at : ${_formatDate(widget.task.deadlineAt)}", // Directly using the DateTime
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: contentFont,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //FORMAT DATETIME
  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  //ASSET IMAGE
  Widget AssetImage(String urlImage, double width, double height) {
    return Image.asset(
      "assets/images/$urlImage",
      width: width,
      height: height,
    );
  }

  //TOAST CONFIRM DELETE
  void _showConfirmDeleteToast(BuildContext context) {
    Flushbar(
      messageText: Container(
        child: Stack(
          children: [
            // Positioned.fill(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     color: Colors.grey.withOpacity(0.1),
            //   ),
            // ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: TextButton(
                      onPressed: () {
                        _deleteTaskByID(widget.task.id);
                      },
                      child: const Text(
                        "Delete TO DO",
                        style: TextStyle(
                          fontSize: 15, // Kích thước font chữ
                          fontWeight: FontWeight.w600, // Kiểu chữ đậm
                          color: Colors.red, // Màu chữ
                          fontFamily: contentFont, // Font chữ tùy chỉnh
                        ),
                      )),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 15, // Kích thước font chữ
                          fontWeight: FontWeight.w600, // Kiểu chữ đậm
                          color: Colors.green[700], // Màu chữ
                          fontFamily: contentFont, // Font chữ tùy chỉnh
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.transparent, // Màu nền của Toast
      margin: const EdgeInsets.all(15), // Lề của Toast
      borderRadius: BorderRadius.circular(8), // Bo góc cho Toast
    ).show(context);
  }

  //TOAST CLOCK
  void _showTimeToast(BuildContext context, DateTime createdTime, DateTime deadlineTime) {
    Flushbar(
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create this task when: ${_formatDate(createdTime)}",
            style: TextStyle(
              fontSize: 15, // Kích thước font chữ
              fontWeight: FontWeight.w600, // Kiểu chữ đậm
              color: Colors.green[700], // Màu chữ
              fontFamily: contentFont, // Font chữ tùy chỉnh
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Deadline this task when: ${_formatDate(deadlineTime)}",
            style: const TextStyle(
              fontSize: 15, // Kích thước font chữ
              fontWeight: FontWeight.w600, // Kiểu chữ đậm
              color: secondColors, // Màu chữ
              fontFamily: contentFont, // Font chữ tùy chỉnh
            ),
          ),
        ],
      ),
      boxShadows: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3)),
      ],
      duration: const Duration(seconds: 5),
      backgroundColor: fiveColors, // Màu nền của Toast
      margin: const EdgeInsets.all(8), // Lề của Toast
      borderRadius: BorderRadius.circular(8), // Bo góc cho Toast
    ).show(context);
  }

  //PICK DATE
  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    );
    return pickedDate;
  }

  // SHOW MODAL UPDATE
  void _showUpdateDialog() {
    int taskId = widget.task.id;
    String taskTitle = widget.task.name;
    String taskDescription = widget.task.description;
    DateTime? taskDeadlineAt;

    //MODAL BOTTOM SHEET
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: primaryColors,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: primaryColors),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //TASK BAR NGANG
                  Center(
                    child: Container(
                      width: 70,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200]),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TITLE
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: const TextStyle(
                          color: fiveColors,
                          fontFamily: contentFont,
                          fontWeight: FontWeight.w600),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: const TextStyle(
                        color: fiveColors,
                        fontFamily: contentFont,
                        fontWeight: FontWeight.w600),
                    onChanged: (value) {
                      taskTitle = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  // DESCRIPTION
                  Container(
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                            color: fiveColors,
                            fontFamily: contentFont,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      style: const TextStyle(
                          color: fiveColors,
                          fontFamily: contentFont,
                          fontWeight: FontWeight.w600),
                      maxLines: 12, // Multi-line for description
                      minLines: 10,
                      onChanged: (value) {
                        taskDescription = value;
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // DEADLINE
                  TextFormField(
                    controller: _deadlineController,
                    decoration: InputDecoration(
                        hintText: 'Deadline (Optional)',
                        hintStyle: const TextStyle(
                            color: fiveColors,
                            fontFamily: contentFont,
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: Image.asset("assets/images/calendar.png")),
                    readOnly: true,
                    style: const TextStyle(
                        color: fiveColors,
                        fontFamily: contentFont,
                        fontWeight: FontWeight.w600),
                    onTap: () {
                      _selectDate(context).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            taskDeadlineAt =
                                selectedDate; // Gán giá trị cho taskDeadline
                            _deadlineController.text =
                                _formatDate(selectedDate);
                          });
                        }
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // IMAGE
                  InkWell(
                    onTap: () {
                      // _pickImage();
                    },
                    child: TextFormField(
                      // controller: _imagePathController,
                      decoration: InputDecoration(
                          hintText: 'Add Image (Optional)',
                          hintStyle: const TextStyle(
                              color: fiveColors,
                              fontFamily: contentFont,
                              fontWeight: FontWeight.w600),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: Image.asset("assets/images/image.png")),
                      readOnly: true,
                      style: const TextStyle(
                          color: fiveColors,
                          fontFamily: contentFont,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 16),

                  //BUTTON ADD TO DO
                  GestureDetector(
                    onTap: () {
                      if (taskTitle.isEmpty) {
                        _showMessageToast(
                            context, "Title can not empty", false);
                      } else if (taskDescription.isEmpty) {
                        _showMessageToast(
                            context, "Description can not empty", false);
                      } else if (taskDeadlineAt == null) {
                        _showMessageToast(
                            context, "Deadline can not empty", false);
                      } else {
                        _updateTask(
                          taskId,
                        );
                        print(_deadlineController);
                        print(taskDeadlineAt);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: fiveColors),
                      child: const Center(
                        child: Text(
                          'UPDATE TASK',
                          style: TextStyle(
                              color: primaryColors,
                              fontWeight: FontWeight.w600,
                              fontFamily: contentFont,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // MESSAGE TOAST
  void _showMessageToast(BuildContext context, String message, bool status) {
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
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15, // Kích thước font chữ
              fontWeight: FontWeight.w600, // Kiểu chữ đậm
              color: Colors.black, // Màu chữ
              fontFamily: contentFont, // Font chữ tùy chỉnh
            ),
          ),
        ],
      ),
      boxShadows: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3))
      ],
      duration: Duration(seconds: 3),
      backgroundColor: fiveColors, // Màu nền của Toast
      margin: EdgeInsets.all(8), // Lề của Toast
      borderRadius: BorderRadius.circular(8), // Bo góc cho Toast
    ).show(context);
  }
}
