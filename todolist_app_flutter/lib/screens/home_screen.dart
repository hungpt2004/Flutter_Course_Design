import 'dart:io';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app_flutter/constants/constant_value.dart';
import 'package:todolist_app_flutter/widgets/tasks_list.dart';
import '../models/filter_options.dart';
import '../models/task_data.dart'; // Assuming this is your TasksList

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _imagePathController = TextEditingController();
  File? _selectedImage;
  bool status = false;
  bool isFavourite = false;

  //Method pick picture
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imagePathController.text = image.path;
      });
    }
  }

  // Function to add a new task
  void _addNewTask(
      String taskTitle, String taskDescription, DateTime taskDeadline) {
    final taskData = Provider.of<TaskData>(context, listen: false);
    taskData.addTask(taskTitle, taskDescription, DateTime.now(), taskDeadline);
    _showMessageDialog(context, "Add task successfully !", true);
  }

  //Pick date by DatePicker
  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    );

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "TO DO LIST",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontFamily: titleFont,
                            color: primaryColors),
                      ),
                      Image.asset(
                        "assets/images/settings.png",
                        color: primaryColors,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/Union.png",
                            color: secondColors,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "LIST OF TO DO",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                fontFamily: titleFont,
                                color: secondColors),
                          ),
                        ],
                      ),

                      //MENU FILTER
                      PopupMenuButton(
                        color: secondColors,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: secondColors
                          )
                        ),
                        onSelected: (FilterOptions selectedValue) {
                          setState(() {
                            if (selectedValue == FilterOptions.Favourites) {
                              isFavourite = true;
                            } else {
                              isFavourite = false;
                            }
                          });
                        },
                        child: Image.asset(
                          "assets/images/filter.png",
                          color: secondColors,
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            labelTextStyle: MaterialStatePropertyAll(
                                TextStyle(
                                    fontFamily: contentFont,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: fiveColors
                                )
                            ),
                            value: FilterOptions.Favourites,
                            child: Text('Only Favorites'),
                          ),
                          const PopupMenuItem(
                            labelTextStyle: MaterialStatePropertyAll(
                                TextStyle(
                                    fontFamily: contentFont,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: fiveColors
                                )
                            ),
                            value: FilterOptions.All,
                            child: Text('Show All'),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                //TASK LIST CONSUMER PROVIDER
                TasksList(isFavourite), // Display the list of tasks

                SizedBox(height: 20,),

              ],
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddTaskDialog();
            },
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: primaryColors,
                )),
            backgroundColor: primaryColors,
            child: Image.asset("assets/images/plus-circle.png", width: double.infinity, height: double.infinity,)
          )
        ],
      ),
    );
  }

  //ADD TASK FORM
  void _showAddTaskDialog() {
    String taskTitle = '';
    String taskDescription = '';
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
                    controller: _dateController,
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
                            _dateController.text = _formatDate(selectedDate);
                          });
                        }
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // IMAGE
                  InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: TextFormField(
                      controller: _imagePathController,
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
                        _showMessageDialog(
                            context, "Title can not empty", false);
                      } else if (taskDescription.isEmpty) {
                        _showMessageDialog(
                            context, "Description can not empty", false);
                      } else if (taskDeadlineAt == null) {
                        _showMessageDialog(
                            context, "Deadline can not empty", false);
                      } else {
                        _addNewTask(taskTitle, taskDescription,
                            taskDeadlineAt ?? DateTime.now());
                      }
                      print(taskDeadlineAt);
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
                          'ADD TASK',
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
  
}

//FORMAT DATETIME
String _formatDate(DateTime date) {
  return DateFormat('dd MMMM yyyy').format(date);
}

//MESSAGE DIALOG
void _showMessageDialog(BuildContext context, String message, bool status) {
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
            fontFamily: contentFont, // Font chữ tùy chỉnh
          ),
        ),
      ],
    ),
    boxShadows: [
      BoxShadow(
          color: Colors.white.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3)),
    ],
    duration: Duration(seconds: 3),
    backgroundColor: fiveColors, // Màu nền của Toast
    margin: EdgeInsets.all(8), // Lề của Toast
    borderRadius: BorderRadius.circular(8), // Bo góc cho Toast
  ).show(context);
}
