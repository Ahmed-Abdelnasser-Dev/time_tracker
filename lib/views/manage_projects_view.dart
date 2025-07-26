import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/providers/project_task_provider.dart';

class ManageProjectsView extends StatelessWidget {
  const ManageProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          final projects = provider.projects;
          if (projects.isEmpty) {
            return Center(child: Text('No projects found'));
          }
          return ListView.separated(
            itemCount: projects.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              final project = projects[index];
              return ListTile(
                title: Text(
                  project.name,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                leading: Icon(Icons.folder, color: Colors.deepPurple),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text('Delete Project'),
                            content: Text(
                              'Are you sure you want to delete this project? This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                    );
                    if (confirmed == true) {
                      provider.deleteProject(project.id);
                    }
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
          title: Text('Add New Project'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter project name'),
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
                provider.addProject(
                  Project(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
