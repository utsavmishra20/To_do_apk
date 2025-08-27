import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'task_detail_screen.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      body: taskProvider.pendingTasks.isEmpty &&
              taskProvider.completedTasks.isEmpty
          ? const Center(child: Text("No tasks yet"))
          : ListView(
              children: [
                if (taskProvider.pendingTasks.isNotEmpty) ...[
                  const ListTile(title: Text("Pending Tasks")),
                  ...taskProvider.pendingTasks.map((task) {
                    return ListTile(
                      title: Text(task.title),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) =>
                            taskProvider.toggleTaskCompletion(task.id),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskDetailScreen(task: task),
                        ),
                      ),
                    );
                  }),
                ],
                if (taskProvider.completedTasks.isNotEmpty) ...[
                  const ListTile(title: Text("Completed Tasks")),
                  ...taskProvider.completedTasks.map((task) {
                    return ListTile(
                      title: Text(
                        task.title,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) =>
                            taskProvider.toggleTaskCompletion(task.id),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskDetailScreen(task: task),
                        ),
                      ),
                    );
                  }),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTaskScreen()),
        ),
      ),
    );
  }
}
