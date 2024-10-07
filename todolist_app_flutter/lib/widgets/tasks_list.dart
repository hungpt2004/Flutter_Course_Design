import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app_flutter/widgets/tasks_tile.dart';

import '../models/task_data.dart'; // Assuming this is your TaskTile

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: taskData.taskCount,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              taskDescription: task.description,
              taskCreatedAt: task.createdAt,
            );
          },
        );
      },
    );
  }
}
