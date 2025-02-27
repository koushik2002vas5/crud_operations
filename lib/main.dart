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

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  int _priorityValue(String priority) {
    switch (priority) {
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      case 'Low':
        return 1;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        backgroundColor: Colors.blue, // Background color for the app name
      ),
      backgroundColor: const Color.fromARGB(255, 157, 231, 237),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter task name'),
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedPriority,
                  items: ['Low', 'Medium', 'High'].map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Blue color for Add button
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.black), // Black text
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => _toggleTaskCompletion(index),
                    ),
                    title: Text(task.name,
                        style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null)),
                    subtitle: Text('Priority: ${task.priority}'),
                    trailing: ElevatedButton(
                      onPressed: () => _deleteTask(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Red color for Delete button
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white), // White text
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
