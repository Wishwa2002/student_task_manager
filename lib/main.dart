import 'package:flutter/material.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Task Manager',
      home: const TaskHomePage(),
    );
  }
}

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  // Controls the text field
  final TextEditingController _taskController =
      TextEditingController();

  // Stores tasks temporarily in memory
  final List<String> _tasks = [];

  // Add a new task
  void _addTask() {
    final String taskName = _taskController.text.trim();

    // Do not add empty tasks
    if (taskName.isEmpty) {
      return;
    }

    setState(() {
      _tasks.add(taskName);
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task added successfully'),
      ),
    );

    // Clear the input field
    _taskController.clear();
  }

  // Remove a task
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Task Manager'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // UI Improvement 1: Welcome heading
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Manage Your Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Task input area
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task name',
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // UI Improvement 2: Live task counter
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total Tasks: ${_tasks.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Task list
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text('No tasks available'),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            // UI Improvement 3: Task numbering
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),

                            title: Text(_tasks[index]),

                            // Delete button
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeTask(index),
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