import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class Task {
  String name;
  bool isCompleted;
  String priority;

  Task({required this.name, this.isCompleted = false, required this.priority});
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: TaskListScreen(),
    );
  }
}
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController _controller = TextEditingController();
  String _selectedPriority = 'Medium';

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: _controller.text, priority: _selectedPriority));
        tasks.sort((a, b) =>
            _priorityValue(b.priority).compareTo(_priorityValue(a.priority)));
      });
      _controller.clear();
    }
  }
