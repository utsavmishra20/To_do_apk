import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        final updatedTask = provider.pendingTasks.firstWhere(
          (t) => t.id == task.id,
          orElse: () => provider.completedTasks.firstWhere(
            (t) => t.id == task.id,
            orElse: () => task,
          ),
        );

        return Scaffold(
          appBar: AppBar(title: Text(updatedTask.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title: ${updatedTask.title}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (updatedTask.description != null)
                  Text("Description: ${updatedTask.description}"),
                if (updatedTask.duedate != null)
                  Text(
                    "Due Date: ${updatedTask.duedate!.day.toString().padLeft(2, '0')}/"
                    "${updatedTask.duedate!.month.toString().padLeft(2, '0')}/"
                    "${updatedTask.duedate!.year}",
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        provider.deleteTask(updatedTask.id);
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddTaskScreen(task: updatedTask),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
