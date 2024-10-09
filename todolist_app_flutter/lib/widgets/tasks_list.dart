import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app_flutter/widgets/tasks_tile.dart';

import '../models/task_data.dart'; // Assuming this is your TaskTile

class TasksList extends StatelessWidget {
  final bool isFavourite;
  TasksList(this.isFavourite, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: isFavourite ? taskData.favoriteItems.length : taskData.tasks.length,
            itemBuilder: (context, index) {
              final task = isFavourite ? taskData.favoriteItems[index] : taskData.tasks[index];
              return TaskTile(
                task: task,
              );
            },
          ),
        );
      },
    );
  }
}
