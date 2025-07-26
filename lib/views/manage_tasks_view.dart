import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/providers/project_task_provider.dart';

class ManageTasksView extends StatelessWidget {
  const ManageTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tasks'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          final tasks = provider.tasks;
          if (tasks.isEmpty) {
            return Center(child: Text('No tasks found'));
          }
          return ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(
                  task.name,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                leading: Icon(Icons.task, color: Colors.deepPurple),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    provider.deleteTask(task.id);
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.deepPurple.shade50,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> openDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final name = controller.text.trim();
                if (name.isEmpty) return;
                final provider = Provider.of<TimeEntryProvider>(
                  context,
                  listen: false,
                );
                provider.addTask(
                  Task(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                  ),
                );
                Navigator.of(context).pop();
                // Removed Snackbar message for addition
              },
            ),
          ],
        );
      },
    );
  }
}
