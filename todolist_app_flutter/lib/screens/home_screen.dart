import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app_flutter/constants/constant_value.dart';
import 'package:todolist_app_flutter/widgets/tasks_list.dart';

import '../models/task_data.dart'; // Assuming this is your TasksList

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Function to add a new task
  void _addNewTask(String taskTitle, String taskDescription) {
    final taskData = Provider.of<TaskData>(context, listen: false);
    taskData.addTask(taskTitle, taskDescription, DateTime.now()); // You can change DateTime if needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
                      color: primaryColors
                    ),
                  ),
                  Image.asset("assets/images/settings.png", color: primaryColors,)
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
                      Image.asset("assets/images/Union.png", color: secondColors,),
                      const SizedBox(width: 10,),
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
                  Image.asset("assets/images/filter.png", color: secondColors,)
                ],
              ),
            ),
            TasksList(), // Display the list of tasks
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(onPressed: (){

            },
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            ),  
            child: Icon(Icons.add, color: primaryColors,),
            )
          ],
        )

      ),
    );
  }

  void _showAddTaskDialog() {
    String taskTitle = '';
    String taskDescription = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Task Title'),
                onChanged: (value) {
                  taskTitle = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  taskDescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addNewTask(taskTitle, taskDescription);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
