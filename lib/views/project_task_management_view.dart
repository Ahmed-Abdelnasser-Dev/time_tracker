import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/providers/project_task_provider.dart';

class ProjectTaskManagementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Projects and Tasks')),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              return ListTile(
                title: Text(entry.id),
                subtitle: Text('Duration: ${entry.date} hours'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteTimeEntry(entry.id);
                  },
                ),
              );
            },
          );
          // Lists for managing projects and tasks would be implemented here
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new project or task
        },
        child: Icon(Icons.add),
        tooltip: 'Add Project/Task',
      ),
    );
  }
}
