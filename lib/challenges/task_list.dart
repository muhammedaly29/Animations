import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;
  Task(this.title, {this.isDone = false});
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task("Watch Clean Arch Video"),
    Task("Finish Flutter project"),
    Task("Go to the gym"),
  ];

  Future<void> _confirmDelete(int index) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: Text(
          "Are you sure you want to delete '${tasks[index].title}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        tasks.removeAt(index);
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Task deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: ReorderableListView.builder(
        itemCount: tasks.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final task = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, task);
          });
        },
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: ValueKey(task.title),
            direction: DismissDirection.startToEnd, // swipe right only
            confirmDismiss: (_) async {
              // stop auto delete, open dialog instead
              await _confirmDelete(index);
              return false;
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              key: ValueKey(task.title),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.drag_handle),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    setState(() {
                      task.isDone = value ?? false;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
