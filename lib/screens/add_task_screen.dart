import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  String? _description;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? "";
    _description = widget.task?.description;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Task" : "Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Title required" : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: "Description"),
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEditing ? "Update" : "Save"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (isEditing) {
                      final updatedTask = Task(
                        id: widget.task!.id,
                        title: _title,
                        description: _description,
                        isCompleted: widget.task!.isCompleted,
                      );
                      Provider.of<TaskProvider>(context, listen: false)
                          .updateTask(updatedTask);
                    } else {
                      final newTask = Task(
                        id: const Uuid().v4(),
                        title: _title,
                        description: _description,
                      );
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(newTask);
                    }

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
